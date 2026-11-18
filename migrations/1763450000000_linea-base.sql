-- Up Migration
-- Línea base de StatsHub: reproduce exactamente el esquema que existía en schemas/ y views/
-- antes de adoptar migraciones. En una base ya creada con esos scripts, marcar esta
-- migración como aplicada con:  npm run migrate:baseline

-- ===== Origen: schemas/01_seguridad.sql =====
CREATE SCHEMA IF NOT EXISTS seguridad;

CREATE TABLE seguridad.roles (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL,
    descripcion TEXT
);

CREATE TABLE seguridad.usuarios (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    correo VARCHAR(255) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    telefono VARCHAR(20),
    activo BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    rol_id INT NOT NULL,
    FOREIGN KEY (rol_id) REFERENCES seguridad.roles(id)
);

-- ===== Origen: schemas/02_deportivo.sql =====
CREATE SCHEMA IF NOT EXISTS deportivo;

-- =====================================
-- CATEGORIAS
-- =====================================

CREATE TABLE deportivo.categorias (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- =====================================
-- TORNEOS
-- =====================================

CREATE TABLE deportivo.torneos (
    id SERIAL PRIMARY KEY,

    nombre VARCHAR(200) NOT NULL,

    categoria_id INT NOT NULL,

    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,

    estado VARCHAR(30) NOT NULL
        CHECK (
            estado IN (
                'PLANIFICADO',
                'ACTIVO',
                'FINALIZADO'
            )
        ),

    FOREIGN KEY (categoria_id)
        REFERENCES deportivo.categorias(id)
);

-- =====================================
-- EQUIPOS
-- =====================================

CREATE TABLE deportivo.equipos (
    id SERIAL PRIMARY KEY,

    nombre VARCHAR(150) UNIQUE NOT NULL,

    escudo_url TEXT,

    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================
-- JUGADORES
-- =====================================

CREATE TABLE deportivo.jugadores (
    id SERIAL PRIMARY KEY,

    usuario_id UUID UNIQUE,

    rut VARCHAR(20) UNIQUE,

    fecha_nacimiento DATE,

    posicion VARCHAR(50),

    FOREIGN KEY (usuario_id)
        REFERENCES seguridad.usuarios(id)
);

-- =====================================
-- RELACION EQUIPO JUGADOR
-- =====================================

CREATE TABLE deportivo.equipo_jugador (
    id SERIAL PRIMARY KEY,

    equipo_id INT NOT NULL,

    jugador_id INT NOT NULL,

    fecha_desde DATE NOT NULL,

    fecha_hasta DATE,

    activo BOOLEAN DEFAULT TRUE,

    FOREIGN KEY (equipo_id)
        REFERENCES deportivo.equipos(id),

    FOREIGN KEY (jugador_id)
        REFERENCES deportivo.jugadores(id)
);

-- =====================================
-- INSCRIPCION EQUIPOS EN TORNEOS
-- =====================================

CREATE TABLE deportivo.torneo_equipos (
    id SERIAL PRIMARY KEY,

    torneo_id INT NOT NULL,

    equipo_id INT NOT NULL,

    UNIQUE(torneo_id, equipo_id),

    FOREIGN KEY (torneo_id)
        REFERENCES deportivo.torneos(id),

    FOREIGN KEY (equipo_id)
        REFERENCES deportivo.equipos(id)
);

-- =====================================
-- PARTIDOS
-- =====================================

CREATE TABLE deportivo.partidos (
    id SERIAL PRIMARY KEY,

    torneo_id INT NOT NULL,

    equipo_local INT NOT NULL,

    equipo_visita INT NOT NULL,

    fecha_partido TIMESTAMP,

    cancha VARCHAR(200),

    estado VARCHAR(30) DEFAULT 'PROGRAMADO'
        CHECK (
            estado IN (
                'PROGRAMADO',
                'EN_CURSO',
                'FINALIZADO',
                'SUSPENDIDO'
            )
        ),

    FOREIGN KEY (torneo_id)
        REFERENCES deportivo.torneos(id),

    FOREIGN KEY (equipo_local)
        REFERENCES deportivo.equipos(id),

    FOREIGN KEY (equipo_visita)
        REFERENCES deportivo.equipos(id),

    CHECK (equipo_local <> equipo_visita)
);

-- =====================================
-- RESULTADOS
-- =====================================

CREATE TABLE deportivo.resultados (
    partido_id INT PRIMARY KEY,

    goles_local INT DEFAULT 0,
    goles_visita INT DEFAULT 0,

    registrado_por UUID,

    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (partido_id)
        REFERENCES deportivo.partidos(id),

    FOREIGN KEY (registrado_por)
        REFERENCES seguridad.usuarios(id)
);

-- =====================================
-- EVENTOS DE PARTIDO
-- =====================================

CREATE TABLE deportivo.eventos_partido (
    id SERIAL PRIMARY KEY,

    partido_id INT NOT NULL,

    jugador_id INT,

    tipo_evento VARCHAR(50) NOT NULL
        CHECK (
            tipo_evento IN (
                'GOL',
                'ASISTENCIA',
                'AMARILLA',
                'ROJA',
                'LESION',
                'SUSTITUCION'
            )
        ),

    minuto INT NOT NULL,

    descripcion TEXT,

    FOREIGN KEY (partido_id)
        REFERENCES deportivo.partidos(id),

    FOREIGN KEY (jugador_id)
        REFERENCES deportivo.jugadores(id)
);

-- =====================================
-- ESTADISTICAS JUGADORES
-- =====================================

CREATE TABLE deportivo.estadisticas_jugador (
    jugador_id INT PRIMARY KEY,

    partidos INT DEFAULT 0,

    goles INT DEFAULT 0,

    asistencias INT DEFAULT 0,

    amarillas INT DEFAULT 0,

    rojas INT DEFAULT 0,

    FOREIGN KEY (jugador_id)
        REFERENCES deportivo.jugadores(id)
);

-- =====================================
-- NOTIFICACIONES
-- =====================================

CREATE TABLE deportivo.notificaciones (
    id SERIAL PRIMARY KEY,

    usuario_id UUID NOT NULL,

    titulo VARCHAR(200) NOT NULL,

    mensaje TEXT NOT NULL,

    leida BOOLEAN DEFAULT FALSE,

    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (usuario_id)
        REFERENCES seguridad.usuarios(id)
);

-- =====================================
-- INDICES
-- =====================================

CREATE INDEX idx_jugador_usuario
ON deportivo.jugadores(usuario_id);

CREATE INDEX idx_equipo_jugador_equipo
ON deportivo.equipo_jugador(equipo_id);

CREATE INDEX idx_equipo_jugador_jugador
ON deportivo.equipo_jugador(jugador_id);

CREATE INDEX idx_partido_torneo
ON deportivo.partidos(torneo_id);

CREATE INDEX idx_evento_partido
ON deportivo.eventos_partido(partido_id);

CREATE INDEX idx_evento_jugador
ON deportivo.eventos_partido(jugador_id);

-- ===== Origen: schemas/03_pagos.sql =====
CREATE SCHEMA IF NOT EXISTS pagos;

CREATE TABLE pagos.transacciones(
    id SERIAL PRIMARY KEY,
    usuario_id UUID,
    monto NUMERIC(10,2),
    estado VARCHAR(20),
    flow_id VARCHAR(255),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(usuario_id)
    REFERENCES seguridad.usuarios(id)
);

-- ===== Origen: schemas/04_auditoria.sql =====
CREATE SCHEMA IF NOT EXISTS auditoria;

CREATE TABLE auditoria.logs(
    id BIGSERIAL PRIMARY KEY,
    usuario_id UUID,
    accion VARCHAR(200),
    tabla_afectada VARCHAR(100),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ===== Origen: schemas/05_analytics.sql =====
CREATE SCHEMA IF NOT EXISTS analytics;

-- =====================================
-- DIMENSION TIEMPO
-- =====================================

CREATE TABLE analytics.dim_tiempo (
    id SERIAL PRIMARY KEY,

    fecha DATE NOT NULL UNIQUE,

    anio INT NOT NULL,
    trimestre INT NOT NULL,
    mes INT NOT NULL,
    nombre_mes VARCHAR(20) NOT NULL,

    semana INT NOT NULL,

    dia INT NOT NULL,
    dia_semana INT NOT NULL,
    nombre_dia VARCHAR(20) NOT NULL
);

-- =====================================
-- DIMENSION EQUIPO
-- =====================================

CREATE TABLE analytics.dim_equipo (
    id SERIAL PRIMARY KEY,

    equipo_id INT UNIQUE NOT NULL,

    nombre VARCHAR(150) NOT NULL
);

-- =====================================
-- DIMENSION TORNEO
-- =====================================

CREATE TABLE analytics.dim_torneo (
    id SERIAL PRIMARY KEY,

    torneo_id INT UNIQUE NOT NULL,

    nombre VARCHAR(200) NOT NULL,

    categoria VARCHAR(100)
);

-- =====================================
-- DIMENSION JUGADOR
-- =====================================

CREATE TABLE analytics.dim_jugador (
    id SERIAL PRIMARY KEY,

    jugador_id INT UNIQUE NOT NULL,

    nombre_completo VARCHAR(200),

    posicion VARCHAR(50)
);

-- =====================================
-- TABLA DE HECHOS PARTIDOS
-- =====================================

CREATE TABLE analytics.fact_partidos (

    id BIGSERIAL PRIMARY KEY,

    tiempo_id INT NOT NULL,

    torneo_id INT NOT NULL,

    equipo_local_id INT NOT NULL,

    equipo_visita_id INT NOT NULL,

    goles_local INT DEFAULT 0,

    goles_visita INT DEFAULT 0,

    FOREIGN KEY (tiempo_id)
        REFERENCES analytics.dim_tiempo(id),

    FOREIGN KEY (torneo_id)
        REFERENCES analytics.dim_torneo(id),

    FOREIGN KEY (equipo_local_id)
        REFERENCES analytics.dim_equipo(id),

    FOREIGN KEY (equipo_visita_id)
        REFERENCES analytics.dim_equipo(id)
);

-- =====================================
-- TABLA DE HECHOS ESTADISTICAS
-- =====================================

CREATE TABLE analytics.fact_estadisticas_jugador (

    id BIGSERIAL PRIMARY KEY,

    tiempo_id INT NOT NULL,

    jugador_id INT NOT NULL,

    partidos INT DEFAULT 0,

    goles INT DEFAULT 0,

    asistencias INT DEFAULT 0,

    amarillas INT DEFAULT 0,

    rojas INT DEFAULT 0,

    FOREIGN KEY (tiempo_id)
        REFERENCES analytics.dim_tiempo(id),

    FOREIGN KEY (jugador_id)
        REFERENCES analytics.dim_jugador(id)
);

-- =====================================
-- INDICES
-- =====================================

CREATE INDEX idx_fact_partidos_tiempo
ON analytics.fact_partidos(tiempo_id);

CREATE INDEX idx_fact_partidos_torneo
ON analytics.fact_partidos(torneo_id);

CREATE INDEX idx_fact_estadisticas_jugador
ON analytics.fact_estadisticas_jugador(jugador_id);

CREATE INDEX idx_fact_estadisticas_tiempo
ON analytics.fact_estadisticas_jugador(tiempo_id);

-- ===== Origen: views/vw_partidos.sql =====
CREATE OR REPLACE VIEW deportivo.vw_partidos AS
SELECT
    p.id,
    el.nombre AS equipo_local,
    ev.nombre AS equipo_visita,
    p.fecha_partido,
    p.estado
FROM deportivo.partidos p
INNER JOIN deportivo.equipos el
    ON el.id = p.equipo_local
INNER JOIN deportivo.equipos ev
    ON ev.id = p.equipo_visita;

-- ===== Origen: views/vw_goleadores.sql =====
CREATE OR REPLACE VIEW deportivo.vw_goleadores AS
SELECT
    u.nombre,
    u.apellido,
    e.goles
FROM deportivo.estadisticas_jugador e
INNER JOIN deportivo.jugadores j
    ON j.id = e.jugador_id
INNER JOIN seguridad.usuarios u
    ON u.id = j.usuario_id
ORDER BY e.goles DESC;

-- ===== Origen: views/vw_tabla_posiciones.sql =====
CREATE OR REPLACE VIEW deportivo.vw_tabla_posiciones AS
SELECT
    id,
    nombre
FROM deportivo.equipos;

-- Down Migration
DROP SCHEMA IF EXISTS analytics CASCADE;
DROP SCHEMA IF EXISTS auditoria CASCADE;
DROP SCHEMA IF EXISTS pagos CASCADE;
DROP SCHEMA IF EXISTS deportivo CASCADE;
DROP SCHEMA IF EXISTS seguridad CASCADE;
