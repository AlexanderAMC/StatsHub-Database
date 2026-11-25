-- Up Migration
-- Modelo freemium: planes Básico/Pro/Ultra por semana, mes o año (desbloquean funciones; nunca
-- el rol administrador), torneos con dueño (organizador del plan Ultra), cobros de inscripción y
-- planilla a los equipos, e informes y liquidación de pagos de árbitros y estadígrafos.

-- ===================== PLANES Y SUSCRIPCIONES =====================

CREATE TABLE pagos.planes (
    codigo VARCHAR(20) PRIMARY KEY CHECK (codigo IN ('BASICO', 'PRO', 'ULTRA')),
    nombre VARCHAR(60) NOT NULL,
    descripcion TEXT,
    nivel SMALLINT NOT NULL UNIQUE,                 -- 1 Básico < 2 Pro < 3 Ultra
    precio_semana NUMERIC(10,0) NOT NULL CHECK (precio_semana >= 0),
    precio_mes NUMERIC(10,0) NOT NULL CHECK (precio_mes >= 0),
    precio_anio NUMERIC(10,0) NOT NULL CHECK (precio_anio >= 0),
    activo BOOLEAN NOT NULL DEFAULT true,
    actualizado_en TIMESTAMPTZ NOT NULL DEFAULT now()
);

INSERT INTO pagos.planes (codigo, nombre, descripcion, nivel, precio_semana, precio_mes, precio_anio) VALUES
('BASICO', 'Plan Básico', 'Estadísticas detalladas (goleadores, asistencias, Fair Play), fichas de jugadores y exportación de reportes.', 1, 990, 2990, 29900),
('PRO', 'Plan Pro', 'Todo lo del Básico, panel de rendimiento y predicción con Machine Learning, gestión del plantel de tu equipo y pago de sus cobros.', 2, 1990, 4990, 49900),
('ULTRA', 'Plan Ultra', 'Todo lo del Pro y organización de torneos propios: equipos, fixture, actas, árbitros y estadígrafos, cobros a equipos y pagos a oficiales.', 3, 4990, 12990, 129900);

CREATE TABLE pagos.suscripciones (
    id SERIAL PRIMARY KEY,
    usuario_id UUID NOT NULL REFERENCES seguridad.usuarios(id) ON DELETE CASCADE,
    plan_codigo VARCHAR(20) NOT NULL REFERENCES pagos.planes(codigo),
    periodo VARCHAR(10) NOT NULL CHECK (periodo IN ('SEMANA', 'MES', 'ANIO')),
    monto NUMERIC(10,0) NOT NULL CHECK (monto >= 0),
    estado VARCHAR(12) NOT NULL DEFAULT 'PENDIENTE' CHECK (estado IN ('PENDIENTE', 'ACTIVA', 'CANCELADA')),
    inicio TIMESTAMPTZ,
    fin TIMESTAMPTZ,
    aviso_vencimiento_en TIMESTAMPTZ,
    creada_en TIMESTAMPTZ NOT NULL DEFAULT now(),
    CHECK (fin IS NULL OR inicio IS NULL OR fin > inicio)
);
CREATE INDEX idx_suscripciones_usuario_fin ON pagos.suscripciones (usuario_id, fin DESC) WHERE estado = 'ACTIVA';

-- ===================== TORNEOS CON DUEÑO =====================

-- NULL = torneo de la liga (lo gestionan administradores y organizadores de la liga).
ALTER TABLE deportivo.torneos
    ADD COLUMN organizador_id UUID REFERENCES seguridad.usuarios(id) ON DELETE SET NULL;
CREATE INDEX idx_torneos_organizador ON deportivo.torneos (organizador_id);
-- El nombre ya no es único en toda la plataforma, sino por organizador.
DROP INDEX IF EXISTS deportivo.torneos_nombre_unico;
CREATE UNIQUE INDEX torneos_nombre_unico ON deportivo.torneos (COALESCE(organizador_id, '00000000-0000-0000-0000-000000000000'::uuid), LOWER(nombre));

-- ===================== COBROS A EQUIPOS =====================

CREATE TABLE pagos.cobros (
    id SERIAL PRIMARY KEY,
    torneo_id INT NOT NULL REFERENCES deportivo.torneos(id) ON DELETE CASCADE,
    equipo_id INT NOT NULL REFERENCES deportivo.equipos(id) ON DELETE CASCADE,
    partido_id INT REFERENCES deportivo.partidos(id) ON DELETE SET NULL,
    tipo VARCHAR(12) NOT NULL CHECK (tipo IN ('INSCRIPCION', 'PLANILLA')),
    concepto VARCHAR(200) NOT NULL,
    monto NUMERIC(10,0) NOT NULL CHECK (monto >= 350),
    estado VARCHAR(10) NOT NULL DEFAULT 'PENDIENTE' CHECK (estado IN ('PENDIENTE', 'PAGADO', 'ANULADO')),
    creado_por UUID REFERENCES seguridad.usuarios(id) ON DELETE SET NULL,
    creado_en TIMESTAMPTZ NOT NULL DEFAULT now(),
    pagado_en TIMESTAMPTZ
);
CREATE INDEX idx_cobros_equipo ON pagos.cobros (equipo_id, estado);
CREATE INDEX idx_cobros_torneo ON pagos.cobros (torneo_id);

ALTER TABLE pagos.transacciones
    ADD COLUMN tipo VARCHAR(12) NOT NULL DEFAULT 'INSCRIPCION' CHECK (tipo IN ('INSCRIPCION', 'PLANILLA', 'SUSCRIPCION')),
    ADD COLUMN cobro_id INT REFERENCES pagos.cobros(id) ON DELETE SET NULL,
    ADD COLUMN suscripcion_id INT REFERENCES pagos.suscripciones(id) ON DELETE SET NULL,
    ADD COLUMN concepto VARCHAR(200);

-- ===================== OFICIALES DE PARTIDO =====================

-- Tarifa que el árbitro o estadígrafo cobra por partido (la define en su perfil).
ALTER TABLE seguridad.usuarios
    ADD COLUMN tarifa_partido NUMERIC(10,0) CHECK (tarifa_partido >= 0);

-- Tarifa acordada por torneo (tiene prioridad sobre la del perfil).
CREATE TABLE deportivo.torneo_oficiales (
    torneo_id INT NOT NULL REFERENCES deportivo.torneos(id) ON DELETE CASCADE,
    usuario_id UUID NOT NULL REFERENCES seguridad.usuarios(id) ON DELETE CASCADE,
    tarifa NUMERIC(10,0) NOT NULL CHECK (tarifa >= 0),
    PRIMARY KEY (torneo_id, usuario_id)
);

ALTER TABLE deportivo.partidos
    -- Si el árbitro también hizo de estadígrafo, se le pagan ambas funciones solo con esta marca.
    ADD COLUMN doble_funcion BOOLEAN NOT NULL DEFAULT false,
    -- RF-31: informe del árbitro y validación (firma digital) del acta.
    ADD COLUMN informe_arbitral TEXT,
    ADD COLUMN acta_validada_en TIMESTAMPTZ,
    ADD COLUMN acta_validada_por UUID REFERENCES seguridad.usuarios(id) ON DELETE SET NULL;

CREATE TABLE pagos.liquidaciones (
    id SERIAL PRIMARY KEY,
    oficial_id UUID NOT NULL REFERENCES seguridad.usuarios(id) ON DELETE RESTRICT,
    creada_por UUID REFERENCES seguridad.usuarios(id) ON DELETE SET NULL,
    torneo_id INT REFERENCES deportivo.torneos(id) ON DELETE SET NULL,
    cantidad_partidos INT NOT NULL CHECK (cantidad_partidos > 0),
    monto_total NUMERIC(12,0) NOT NULL CHECK (monto_total >= 0),
    estado VARCHAR(10) NOT NULL DEFAULT 'PENDIENTE' CHECK (estado IN ('PENDIENTE', 'PAGADA', 'RECIBIDA', 'OBSERVADA', 'ANULADA')),
    medio_pago VARCHAR(40),
    referencia VARCHAR(100),
    pagada_en TIMESTAMPTZ,
    observacion TEXT,
    creada_en TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_liquidaciones_oficial ON pagos.liquidaciones (oficial_id, creada_en DESC);

CREATE TABLE pagos.liquidacion_partidos (
    liquidacion_id INT NOT NULL REFERENCES pagos.liquidaciones(id) ON DELETE CASCADE,
    partido_id INT NOT NULL REFERENCES deportivo.partidos(id) ON DELETE RESTRICT,
    funcion VARCHAR(12) NOT NULL CHECK (funcion IN ('ARBITRO', 'ESTADIGRAFO')),
    tarifa NUMERIC(10,0) NOT NULL CHECK (tarifa >= 0),
    PRIMARY KEY (liquidacion_id, partido_id, funcion)
);
-- Un partido y función se liquida una sola vez (al anular una liquidación se borran sus filas aquí).
CREATE TABLE pagos.partidos_liquidados (
    partido_id INT NOT NULL REFERENCES deportivo.partidos(id) ON DELETE RESTRICT,
    funcion VARCHAR(12) NOT NULL CHECK (funcion IN ('ARBITRO', 'ESTADIGRAFO')),
    liquidacion_id INT NOT NULL REFERENCES pagos.liquidaciones(id) ON DELETE CASCADE,
    PRIMARY KEY (partido_id, funcion)
);

ALTER TABLE deportivo.notificaciones DROP CONSTRAINT IF EXISTS notificaciones_tipo_check;
ALTER TABLE deportivo.notificaciones ADD CONSTRAINT notificaciones_tipo_check
    CHECK (tipo IN ('programacion', 'cambio', 'resultado', 'recordatorio', 'transferencia', 'acta', 'pago', 'plan', 'cobro', 'liquidacion'));


-- Down Migration
ALTER TABLE deportivo.notificaciones DROP CONSTRAINT IF EXISTS notificaciones_tipo_check;
DELETE FROM deportivo.notificaciones WHERE tipo IN ('plan', 'cobro', 'liquidacion');
ALTER TABLE deportivo.notificaciones ADD CONSTRAINT notificaciones_tipo_check
    CHECK (tipo IN ('programacion', 'cambio', 'resultado', 'recordatorio', 'transferencia', 'acta', 'pago'));

DROP TABLE IF EXISTS pagos.partidos_liquidados;
DROP TABLE IF EXISTS pagos.liquidacion_partidos;
DROP TABLE IF EXISTS pagos.liquidaciones;
ALTER TABLE deportivo.partidos
    DROP COLUMN IF EXISTS acta_validada_por,
    DROP COLUMN IF EXISTS acta_validada_en,
    DROP COLUMN IF EXISTS informe_arbitral,
    DROP COLUMN IF EXISTS doble_funcion;
DROP TABLE IF EXISTS deportivo.torneo_oficiales;
ALTER TABLE seguridad.usuarios DROP COLUMN IF EXISTS tarifa_partido;

ALTER TABLE pagos.transacciones
    DROP COLUMN IF EXISTS concepto,
    DROP COLUMN IF EXISTS suscripcion_id,
    DROP COLUMN IF EXISTS cobro_id,
    DROP COLUMN IF EXISTS tipo;
DROP TABLE IF EXISTS pagos.cobros;

DROP INDEX IF EXISTS deportivo.torneos_nombre_unico;
CREATE UNIQUE INDEX torneos_nombre_unico ON deportivo.torneos (LOWER(nombre));
DROP INDEX IF EXISTS deportivo.idx_torneos_organizador;
ALTER TABLE deportivo.torneos DROP COLUMN IF EXISTS organizador_id;

DROP TABLE IF EXISTS pagos.suscripciones;
DROP TABLE IF EXISTS pagos.planes;
