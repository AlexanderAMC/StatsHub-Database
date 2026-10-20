TRUNCATE TABLE analytics.fact_estadisticas_jugador
RESTART IDENTITY CASCADE;

INSERT INTO analytics.fact_estadisticas_jugador (
    tiempo_id,
    jugador_id,
    partidos,
    goles,
    asistencias,
    amarillas,
    rojas
)
SELECT
    (
        SELECT id
        FROM analytics.dim_tiempo
        WHERE fecha = CURRENT_DATE
        LIMIT 1
    ),
    dj.id,
    ej.partidos,
    ej.goles,
    ej.asistencias,
    ej.amarillas,
    ej.rojas
FROM deportivo.estadisticas_jugador ej
INNER JOIN analytics.dim_jugador dj
    ON dj.jugador_id = ej.jugador_id;