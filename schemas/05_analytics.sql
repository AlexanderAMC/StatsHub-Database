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