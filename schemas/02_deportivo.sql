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