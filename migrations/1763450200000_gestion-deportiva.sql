-- Up Migration
-- Esquema para las fases B–F: gestión deportiva, actas digitales, seguridad de cuentas,
-- notificaciones y pagos con Flow.

-- ===================== SEGURIDAD =====================

ALTER TABLE seguridad.usuarios
    -- RF-02: al cerrar sesión (o cambiar la contraseña) se incrementa y los JWT anteriores dejan de valer.
    ADD COLUMN token_version INT NOT NULL DEFAULT 0,
    -- RNF-11 (Ley 19.628): fecha de aceptación explícita de la política de privacidad.
    ADD COLUMN acepta_privacidad_en TIMESTAMPTZ,
    -- RF-45: preferencia de notificaciones y marca de "leídas hasta".
    ADD COLUMN recibe_notificaciones BOOLEAN NOT NULL DEFAULT true,
    ADD COLUMN notificaciones_leidas_hasta TIMESTAMPTZ;

-- RF-03: tokens de recuperación de contraseña (solo se guarda el hash SHA-256 del token).
CREATE TABLE seguridad.password_resets (
    id BIGSERIAL PRIMARY KEY,
    usuario_id UUID NOT NULL REFERENCES seguridad.usuarios(id) ON DELETE CASCADE,
    token_hash CHAR(64) NOT NULL UNIQUE,
    expira_en TIMESTAMPTZ NOT NULL,
    usado_en TIMESTAMPTZ,
    creado_en TIMESTAMPTZ NOT NULL DEFAULT now()
);
CREATE INDEX idx_password_resets_usuario ON seguridad.password_resets (usuario_id);

-- RF-06: bitácora con más contexto.
ALTER TABLE auditoria.logs
    ADD COLUMN registro_id VARCHAR(100),
    ADD COLUMN detalle JSONB,
    ADD COLUMN ip VARCHAR(64);

-- ===================== LIGA (RF-07) =====================

CREATE TABLE deportivo.liga (
    id SMALLINT PRIMARY KEY DEFAULT 1 CHECK (id = 1),
    nombre VARCHAR(200) NOT NULL DEFAULT 'Liga Deportiva Comunal de Puente Alto',
    descripcion TEXT,
    correo_contacto VARCHAR(255),
    telefono VARCHAR(30),
    recintos TEXT[] NOT NULL DEFAULT ARRAY['Cancha 1', 'Cancha 2', 'Estadio Municipal'],
    costo_inscripcion NUMERIC(10,0) NOT NULL DEFAULT 50000 CHECK (costo_inscripcion >= 0),
    actualizado_en TIMESTAMPTZ NOT NULL DEFAULT now()
);
INSERT INTO deportivo.liga (id) VALUES (1);

-- ===================== CATEGORÍAS Y TORNEOS =====================

ALTER TABLE deportivo.categorias
    ADD COLUMN edad_min SMALLINT CHECK (edad_min BETWEEN 0 AND 100),
    ADD COLUMN edad_max SMALLINT CHECK (edad_max BETWEEN 0 AND 100),
    ADD CONSTRAINT categorias_edades_check CHECK (edad_min IS NULL OR edad_max IS NULL OR edad_max >= edad_min);

ALTER TABLE deportivo.torneos
    ADD COLUMN cupos SMALLINT NOT NULL DEFAULT 10 CHECK (cupos BETWEEN 2 AND 64),
    ADD COLUMN formato VARCHAR(30) NOT NULL DEFAULT 'LIGA' CHECK (formato IN ('LIGA', 'COPA', 'LIGA_Y_PLAYOFF')),
    ADD COLUMN costo_inscripcion NUMERIC(10,0) CHECK (costo_inscripcion >= 0);

ALTER TABLE deportivo.torneos DROP CONSTRAINT torneos_estado_check;
ALTER TABLE deportivo.torneos ADD CONSTRAINT torneos_estado_check
    CHECK (estado IN ('PLANIFICADO', 'INSCRIPCIONES', 'ACTIVO', 'FINALIZADO', 'CANCELADO'));
CREATE UNIQUE INDEX torneos_nombre_unico ON deportivo.torneos (LOWER(nombre));

-- ===================== EQUIPOS =====================

ALTER TABLE deportivo.equipos
    ADD COLUMN entrenador VARCHAR(150),
    ADD COLUMN entrenador_id UUID REFERENCES seguridad.usuarios(id) ON DELETE SET NULL;
CREATE INDEX idx_equipos_entrenador ON deportivo.equipos (entrenador_id);

-- RF-40: estado de la inscripción (pasa a INSCRITO cuando Flow confirma el pago).
ALTER TABLE deportivo.torneo_equipos
    ADD COLUMN estado_inscripcion VARCHAR(20) NOT NULL DEFAULT 'PENDIENTE'
        CHECK (estado_inscripcion IN ('PENDIENTE', 'INSCRITO')),
    ADD COLUMN fecha_inscripcion TIMESTAMPTZ NOT NULL DEFAULT now();

-- ===================== JUGADORES =====================

ALTER TABLE deportivo.jugadores
    ADD COLUMN nombre VARCHAR(150),
    ADD COLUMN numero SMALLINT CHECK (numero BETWEEN 1 AND 99);

-- Los jugadores existentes toman el nombre de su cuenta de usuario.
UPDATE deportivo.jugadores j
SET nombre = u.nombre || ' ' || u.apellido
FROM seguridad.usuarios u
WHERE j.usuario_id = u.id AND j.nombre IS NULL;
UPDATE deportivo.jugadores SET nombre = 'Jugador ' || id WHERE nombre IS NULL;
ALTER TABLE deportivo.jugadores ALTER COLUMN nombre SET NOT NULL;

-- RF-17: historial de transferencias (equipo NULL = sin equipo / agente libre).
CREATE TABLE deportivo.transferencias (
    id SERIAL PRIMARY KEY,
    jugador_id INT NOT NULL REFERENCES deportivo.jugadores(id) ON DELETE CASCADE,
    desde_equipo_id INT REFERENCES deportivo.equipos(id) ON DELETE SET NULL,
    hacia_equipo_id INT REFERENCES deportivo.equipos(id) ON DELETE SET NULL,
    fecha TIMESTAMPTZ NOT NULL DEFAULT now(),
    registrado_por UUID REFERENCES seguridad.usuarios(id) ON DELETE SET NULL,
    CHECK (desde_equipo_id IS DISTINCT FROM hacia_equipo_id)
);
CREATE INDEX idx_transferencias_jugador ON deportivo.transferencias (jugador_id);

-- ===================== PARTIDOS Y ACTAS =====================

ALTER TABLE deportivo.partidos
    ADD COLUMN jornada SMALLINT NOT NULL DEFAULT 1 CHECK (jornada >= 1),
    ADD COLUMN arbitro_id UUID REFERENCES seguridad.usuarios(id) ON DELETE SET NULL,
    ADD COLUMN estadigrafo_id UUID REFERENCES seguridad.usuarios(id) ON DELETE SET NULL,
    ADD COLUMN minuto SMALLINT NOT NULL DEFAULT 0 CHECK (minuto BETWEEN 0 AND 130),
    -- Convocatoria del acta: {"home": [ids], "away": [ids]}
    ADD COLUMN alineacion JSONB,
    ADD COLUMN iniciado_en TIMESTAMPTZ,
    -- RF-30 / HU-08: una vez cerrada, el acta no admite cambios.
    ADD COLUMN acta_cerrada_en TIMESTAMPTZ,
    ADD COLUMN acta_cerrada_por UUID REFERENCES seguridad.usuarios(id) ON DELETE SET NULL,
    ADD COLUMN actualizado_en TIMESTAMPTZ NOT NULL DEFAULT now();
CREATE INDEX idx_partidos_arbitro ON deportivo.partidos (arbitro_id);
CREATE INDEX idx_partidos_estadigrafo ON deportivo.partidos (estadigrafo_id);

-- Los partidos finalizados previos se consideran con el acta cerrada.
UPDATE deportivo.partidos SET acta_cerrada_en = now() WHERE estado = 'FINALIZADO';

ALTER TABLE deportivo.eventos_partido
    ADD COLUMN lado VARCHAR(10) CHECK (lado IN ('LOCAL', 'VISITA')),
    ADD COLUMN asistencia_jugador_id INT REFERENCES deportivo.jugadores(id) ON DELETE SET NULL,
    ADD COLUMN relacionado_jugador_id INT REFERENCES deportivo.jugadores(id) ON DELETE SET NULL,
    ADD COLUMN registrado_por UUID REFERENCES seguridad.usuarios(id) ON DELETE SET NULL,
    ADD COLUMN creado_en TIMESTAMPTZ NOT NULL DEFAULT now();

-- ===================== NOTIFICACIONES =====================

-- usuario_id NULL = notificación para toda la liga.
ALTER TABLE deportivo.notificaciones
    ALTER COLUMN usuario_id DROP NOT NULL,
    ADD COLUMN tipo VARCHAR(30) NOT NULL DEFAULT 'resultado'
        CHECK (tipo IN ('programacion', 'cambio', 'resultado', 'recordatorio', 'transferencia', 'acta', 'pago')),
    ADD COLUMN partido_id INT REFERENCES deportivo.partidos(id) ON DELETE CASCADE;
CREATE INDEX idx_notificaciones_fecha ON deportivo.notificaciones (fecha DESC);

-- ===================== PAGOS (Flow) =====================

ALTER TABLE pagos.transacciones
    ADD COLUMN equipo_id INT REFERENCES deportivo.equipos(id) ON DELETE SET NULL,
    ADD COLUMN torneo_id INT REFERENCES deportivo.torneos(id) ON DELETE SET NULL,
    ADD COLUMN orden_comercio VARCHAR(60) UNIQUE,
    ADD COLUMN flow_token VARCHAR(255),
    ADD COLUMN correo_pagador VARCHAR(255),
    ADD COLUMN medio_pago VARCHAR(60),
    ADD COLUMN fecha_pago TIMESTAMPTZ,
    ADD COLUMN actualizado_en TIMESTAMPTZ NOT NULL DEFAULT now();
UPDATE pagos.transacciones SET estado = 'PENDIENTE' WHERE estado IS NULL OR estado NOT IN ('PENDIENTE', 'PAGADO', 'RECHAZADO', 'ANULADO');
ALTER TABLE pagos.transacciones
    ALTER COLUMN estado SET DEFAULT 'PENDIENTE',
    ALTER COLUMN estado SET NOT NULL,
    ADD CONSTRAINT transacciones_estado_check CHECK (estado IN ('PENDIENTE', 'PAGADO', 'RECHAZADO', 'ANULADO'));
CREATE INDEX idx_transacciones_flow_token ON pagos.transacciones (flow_token);
CREATE INDEX idx_transacciones_equipo ON pagos.transacciones (equipo_id);


-- Down Migration
DROP INDEX IF EXISTS pagos.idx_transacciones_equipo;
DROP INDEX IF EXISTS pagos.idx_transacciones_flow_token;
ALTER TABLE pagos.transacciones
    DROP CONSTRAINT IF EXISTS transacciones_estado_check,
    ALTER COLUMN estado DROP NOT NULL,
    ALTER COLUMN estado DROP DEFAULT,
    DROP COLUMN IF EXISTS actualizado_en,
    DROP COLUMN IF EXISTS fecha_pago,
    DROP COLUMN IF EXISTS medio_pago,
    DROP COLUMN IF EXISTS correo_pagador,
    DROP COLUMN IF EXISTS flow_token,
    DROP COLUMN IF EXISTS orden_comercio,
    DROP COLUMN IF EXISTS torneo_id,
    DROP COLUMN IF EXISTS equipo_id;

DROP INDEX IF EXISTS deportivo.idx_notificaciones_fecha;
DELETE FROM deportivo.notificaciones WHERE usuario_id IS NULL;
ALTER TABLE deportivo.notificaciones
    DROP COLUMN IF EXISTS partido_id,
    DROP COLUMN IF EXISTS tipo,
    ALTER COLUMN usuario_id SET NOT NULL;

ALTER TABLE deportivo.eventos_partido
    DROP COLUMN IF EXISTS creado_en,
    DROP COLUMN IF EXISTS registrado_por,
    DROP COLUMN IF EXISTS relacionado_jugador_id,
    DROP COLUMN IF EXISTS asistencia_jugador_id,
    DROP COLUMN IF EXISTS lado;

DROP INDEX IF EXISTS deportivo.idx_partidos_estadigrafo;
DROP INDEX IF EXISTS deportivo.idx_partidos_arbitro;
ALTER TABLE deportivo.partidos
    DROP COLUMN IF EXISTS actualizado_en,
    DROP COLUMN IF EXISTS acta_cerrada_por,
    DROP COLUMN IF EXISTS acta_cerrada_en,
    DROP COLUMN IF EXISTS iniciado_en,
    DROP COLUMN IF EXISTS alineacion,
    DROP COLUMN IF EXISTS minuto,
    DROP COLUMN IF EXISTS estadigrafo_id,
    DROP COLUMN IF EXISTS arbitro_id,
    DROP COLUMN IF EXISTS jornada;

DROP TABLE IF EXISTS deportivo.transferencias;
ALTER TABLE deportivo.jugadores DROP COLUMN IF EXISTS numero, DROP COLUMN IF EXISTS nombre;

ALTER TABLE deportivo.torneo_equipos DROP COLUMN IF EXISTS fecha_inscripcion, DROP COLUMN IF EXISTS estado_inscripcion;
DROP INDEX IF EXISTS deportivo.idx_equipos_entrenador;
ALTER TABLE deportivo.equipos DROP COLUMN IF EXISTS entrenador_id, DROP COLUMN IF EXISTS entrenador;

DROP INDEX IF EXISTS deportivo.torneos_nombre_unico;
UPDATE deportivo.torneos SET estado = 'PLANIFICADO' WHERE estado IN ('INSCRIPCIONES', 'CANCELADO');
ALTER TABLE deportivo.torneos DROP CONSTRAINT torneos_estado_check;
ALTER TABLE deportivo.torneos ADD CONSTRAINT torneos_estado_check
    CHECK (estado IN ('PLANIFICADO', 'ACTIVO', 'FINALIZADO'));
ALTER TABLE deportivo.torneos
    DROP COLUMN IF EXISTS costo_inscripcion,
    DROP COLUMN IF EXISTS formato,
    DROP COLUMN IF EXISTS cupos;

ALTER TABLE deportivo.categorias
    DROP CONSTRAINT IF EXISTS categorias_edades_check,
    DROP COLUMN IF EXISTS edad_max,
    DROP COLUMN IF EXISTS edad_min;

DROP TABLE IF EXISTS deportivo.liga;

ALTER TABLE auditoria.logs DROP COLUMN IF EXISTS ip, DROP COLUMN IF EXISTS detalle, DROP COLUMN IF EXISTS registro_id;
DROP TABLE IF EXISTS seguridad.password_resets;

ALTER TABLE seguridad.usuarios
    DROP COLUMN IF EXISTS notificaciones_leidas_hasta,
    DROP COLUMN IF EXISTS recibe_notificaciones,
    DROP COLUMN IF EXISTS acepta_privacidad_en,
    DROP COLUMN IF EXISTS token_version;
