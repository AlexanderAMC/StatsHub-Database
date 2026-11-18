-- =====================================
-- DATOS DE PRUEBA
-- =====================================
-- Requisitos: ejecutar antes 01_roles.sql, 02_usuarios.sql y 03_categorias.sql
-- (02 crea jugador1..3@statshub.cl y organizador@statshub.cl, que este archivo referencia).
-- IMPORTANTE: ejecutar SOLO sobre una base recién creada. Usa ids fijos (equipos 1-6,
-- torneos 1-2, jugadores 1-3) y no es re-ejecutable; hacerlo idempotente es parte de P1-1.

-- =====================================
-- EQUIPOS
-- =====================================

INSERT INTO deportivo.equipos (nombre)
VALUES
('Deportivo Puente Alto'),
('Atlético Cordillera'),
('Unión Sur'),
('Real Maipo'),
('Club Municipal'),
('Estrella Roja');

-- =====================================
-- TORNEOS
-- =====================================

INSERT INTO deportivo.torneos
(
    nombre,
    categoria_id,
    fecha_inicio,
    fecha_fin,
    estado
)
VALUES
(
    'Copa Apertura 2027',
    1,
    '2027-03-01',
    '2027-06-30',
    'ACTIVO'
),
(
    'Liga Metropolitana 2027',
    2,
    '2027-08-01',
    '2027-12-30',
    'PLANIFICADO'
);

-- =====================================
-- JUGADORES
-- =====================================

INSERT INTO deportivo.jugadores
(
    usuario_id,
    rut,
    fecha_nacimiento,
    posicion
)
SELECT
    id,
    '11111111-1',
    '2000-05-10',
    'DELANTERO'
FROM seguridad.usuarios
WHERE correo='jugador1@statshub.cl';

INSERT INTO deportivo.jugadores
(
    usuario_id,
    rut,
    fecha_nacimiento,
    posicion
)
SELECT
    id,
    '22222222-2',
    '1999-08-22',
    'MEDIOCAMPISTA'
FROM seguridad.usuarios
WHERE correo='jugador2@statshub.cl';

INSERT INTO deportivo.jugadores
(
    usuario_id,
    rut,
    fecha_nacimiento,
    posicion
)
SELECT
    id,
    '33333333-3',
    '2001-01-15',
    'DEFENSA'
FROM seguridad.usuarios
WHERE correo='jugador3@statshub.cl';

-- =====================================
-- RELACION EQUIPO JUGADOR
-- =====================================

INSERT INTO deportivo.equipo_jugador
(
    equipo_id,
    jugador_id,
    fecha_desde
)
VALUES
(1,1,CURRENT_DATE),
(1,2,CURRENT_DATE),
(2,3,CURRENT_DATE);

-- =====================================
-- INSCRIPCION EQUIPOS TORNEO
-- =====================================

INSERT INTO deportivo.torneo_equipos
(
    torneo_id,
    equipo_id
)
VALUES
(1,1),
(1,2),
(1,3),
(1,4),
(1,5),
(1,6);

-- =====================================
-- PARTIDOS
-- =====================================

INSERT INTO deportivo.partidos
(
    torneo_id,
    equipo_local,
    equipo_visita,
    fecha_partido,
    cancha,
    estado
)
VALUES
(
    1,
    1,
    2,
    '2027-03-10 19:00:00',
    'Estadio Municipal',
    'FINALIZADO'
),
(
    1,
    3,
    4,
    '2027-03-10 21:00:00',
    'Estadio Municipal',
    'FINALIZADO'
),
(
    1,
    5,
    6,
    '2027-03-11 18:30:00',
    'Cancha Sur',
    'FINALIZADO'
);

-- =====================================
-- RESULTADOS
-- =====================================

INSERT INTO deportivo.resultados
(
    partido_id,
    goles_local,
    goles_visita
)
VALUES
(1,3,1),
(2,2,2),
(3,0,1);

-- =====================================
-- EVENTOS
-- =====================================

INSERT INTO deportivo.eventos_partido
(
    partido_id,
    jugador_id,
    tipo_evento,
    minuto,
    descripcion
)
VALUES
(
    1,
    1,
    'GOL',
    15,
    'Gol de cabeza'
),
(
    1,
    1,
    'GOL',
    60,
    'Remate fuera del area'
),
(
    1,
    2,
    'ASISTENCIA',
    60,
    'Pase gol'
),
(
    1,
    3,
    'AMARILLA',
    75,
    'Falta tactica'
);

-- =====================================
-- ESTADISTICAS JUGADOR
-- =====================================

INSERT INTO deportivo.estadisticas_jugador
(
    jugador_id,
    partidos,
    goles,
    asistencias,
    amarillas,
    rojas
)
VALUES
(
    1,
    10,
    8,
    2,
    1,
    0
),
(
    2,
    10,
    3,
    5,
    2,
    0
),
(
    3,
    10,
    1,
    1,
    4,
    1
);

-- =====================================
-- NOTIFICACIONES
-- =====================================

INSERT INTO deportivo.notificaciones
(
    usuario_id,
    titulo,
    mensaje
)
SELECT
    id,
    'Bienvenido',
    'Tu cuenta ha sido creada correctamente'
FROM seguridad.usuarios;

-- =====================================
-- TRANSACCION FLOW
-- =====================================

INSERT INTO pagos.transacciones
(
    usuario_id,
    monto,
    estado,
    flow_id
)
SELECT
    id,
    15000,
    'APROBADO',
    'FLOW001'
FROM seguridad.usuarios
WHERE correo='organizador@statshub.cl';

-- =====================================
-- DIMENSION EQUIPO
-- =====================================

INSERT INTO analytics.dim_equipo
(
    equipo_id,
    nombre
)
SELECT
    id,
    nombre
FROM deportivo.equipos;

-- =====================================
-- DIMENSION TORNEO
-- =====================================

INSERT INTO analytics.dim_torneo
(
    torneo_id,
    nombre,
    categoria
)
SELECT
    t.id,
    t.nombre,
    c.nombre
FROM deportivo.torneos t
INNER JOIN deportivo.categorias c
ON c.id = t.categoria_id;

-- =====================================
-- DIMENSION TIEMPO
-- =====================================

INSERT INTO analytics.dim_tiempo
(
    fecha,
    anio,
    trimestre,
    mes,
    nombre_mes,
    semana,
    dia,
    dia_semana,
    nombre_dia
)
VALUES
(
    CURRENT_DATE,
    EXTRACT(YEAR FROM CURRENT_DATE),
    EXTRACT(QUARTER FROM CURRENT_DATE),
    EXTRACT(MONTH FROM CURRENT_DATE),
    TO_CHAR(CURRENT_DATE,'Month'),
    EXTRACT(WEEK FROM CURRENT_DATE),
    EXTRACT(DAY FROM CURRENT_DATE),
    EXTRACT(DOW FROM CURRENT_DATE),
    TO_CHAR(CURRENT_DATE,'Day')
);

-- =====================================
-- HECHOS PARTIDOS
-- =====================================

INSERT INTO analytics.fact_partidos
(
    tiempo_id,
    torneo_id,
    equipo_local_id,
    equipo_visita_id,
    goles_local,
    goles_visita
)
VALUES
(
    1,
    1,
    1,
    2,
    3,
    1
),
(
    1,
    1,
    3,
    4,
    2,
    2
),
(
    1,
    1,
    5,
    6,
    0,
    1
);