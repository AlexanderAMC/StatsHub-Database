/*
========================================
STATSHUB DATABASE INSTALL
========================================
*/

CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- SCHEMAS

CREATE SCHEMA IF NOT EXISTS seguridad;
CREATE SCHEMA IF NOT EXISTS deportivo;
CREATE SCHEMA IF NOT EXISTS pagos;
CREATE SCHEMA IF NOT EXISTS auditoria;
CREATE SCHEMA IF NOT EXISTS analytics;

-- SEGURIDAD

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

    FOREIGN KEY(rol_id)
    REFERENCES seguridad.roles(id)
);

-- DEPORTIVO

CREATE TABLE deportivo.categorias(
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE deportivo.torneos(
    id SERIAL PRIMARY KEY,

    nombre VARCHAR(200) NOT NULL,

    categoria_id INT NOT NULL,

    fecha_inicio DATE NOT NULL,

    fecha_fin DATE,

    estado VARCHAR(30),

    FOREIGN KEY(categoria_id)
    REFERENCES deportivo.categorias(id)
);

CREATE TABLE deportivo.equipos(
    id SERIAL PRIMARY KEY,

    nombre VARCHAR(150) NOT NULL UNIQUE,

    escudo_url TEXT,

    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE deportivo.jugadores(
    id SERIAL PRIMARY KEY,

    usuario_id UUID UNIQUE,

    rut VARCHAR(20),

    fecha_nacimiento DATE,

    posicion VARCHAR(50),

    FOREIGN KEY(usuario_id)
    REFERENCES seguridad.usuarios(id)
);

CREATE TABLE deportivo.equipo_jugador(
    id SERIAL PRIMARY KEY,

    equipo_id INT NOT NULL,

    jugador_id INT NOT NULL,

    fecha_desde DATE,

    fecha_hasta DATE,

    activo BOOLEAN DEFAULT TRUE,

    FOREIGN KEY(equipo_id)
    REFERENCES deportivo.equipos(id),

    FOREIGN KEY(jugador_id)
    REFERENCES deportivo.jugadores(id)
);

CREATE TABLE deportivo.torneo_equipos(
    id SERIAL PRIMARY KEY,

    torneo_id INT NOT NULL,

    equipo_id INT NOT NULL,

    UNIQUE(torneo_id,equipo_id),

    FOREIGN KEY(torneo_id)
    REFERENCES deportivo.torneos(id),

    FOREIGN KEY(equipo_id)
    REFERENCES deportivo.equipos(id)
);

CREATE TABLE deportivo.partidos(
    id SERIAL PRIMARY KEY,

    torneo_id INT NOT NULL,

    equipo_local INT NOT NULL,

    equipo_visita INT NOT NULL,

    fecha_partido TIMESTAMP,

    cancha VARCHAR(200),

    estado VARCHAR(30),

    FOREIGN KEY(torneo_id)
    REFERENCES deportivo.torneos(id),

    FOREIGN KEY(equipo_local)
    REFERENCES deportivo.equipos(id),

    FOREIGN KEY(equipo_visita)
    REFERENCES deportivo.equipos(id)
);

CREATE TABLE deportivo.resultados(
    partido_id INT PRIMARY KEY,

    goles_local INT DEFAULT 0,

    goles_visita INT DEFAULT 0,

    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(partido_id)
    REFERENCES deportivo.partidos(id)
);

CREATE TABLE deportivo.eventos_partido(
    id SERIAL PRIMARY KEY,

    partido_id INT NOT NULL,

    jugador_id INT,

    tipo_evento VARCHAR(50),

    minuto INT,

    descripcion TEXT,

    FOREIGN KEY(partido_id)
    REFERENCES deportivo.partidos(id),

    FOREIGN KEY(jugador_id)
    REFERENCES deportivo.jugadores(id)
);

CREATE TABLE deportivo.estadisticas_jugador(
    jugador_id INT PRIMARY KEY,

    partidos INT DEFAULT 0,

    goles INT DEFAULT 0,

    asistencias INT DEFAULT 0,

    amarillas INT DEFAULT 0,

    rojas INT DEFAULT 0,

    FOREIGN KEY(jugador_id)
    REFERENCES deportivo.jugadores(id)
);

CREATE TABLE deportivo.notificaciones(
    id SERIAL PRIMARY KEY,

    usuario_id UUID,

    titulo VARCHAR(200),

    mensaje TEXT,

    leida BOOLEAN DEFAULT FALSE,

    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY(usuario_id)
    REFERENCES seguridad.usuarios(id)
);

-- PAGOS

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

-- AUDITORIA

CREATE TABLE auditoria.logs(
    id BIGSERIAL PRIMARY KEY,

    usuario_id UUID,

    accion VARCHAR(200),

    tabla_afectada VARCHAR(100),

    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ANALYTICS

CREATE TABLE analytics.dim_equipo(
    id SERIAL PRIMARY KEY,

    equipo_id INT,

    nombre VARCHAR(150)
);

CREATE TABLE analytics.dim_tiempo(
    id SERIAL PRIMARY KEY,

    fecha DATE,

    anio INT,

    mes INT,

    dia INT
);

CREATE TABLE analytics.fact_partidos(
    id BIGSERIAL PRIMARY KEY,

    tiempo_id INT,

    equipo_local_id INT,

    equipo_visita_id INT,

    goles_local INT,

    goles_visita INT,

    FOREIGN KEY(tiempo_id)
    REFERENCES analytics.dim_tiempo(id)
);