TRUNCATE TABLE analytics.fact_partidos
RESTART IDENTITY CASCADE;

INSERT INTO analytics.fact_partidos (
    tiempo_id,
    torneo_id,
    equipo_local_id,
    equipo_visita_id,
    goles_local,
    goles_visita
)
SELECT
    dt.id,
    tor.id,
    el.id,
    ev.id,
    COALESCE(r.goles_local,0),
    COALESCE(r.goles_visita,0)
FROM deportivo.partidos p

INNER JOIN analytics.dim_tiempo dt
    ON dt.fecha = DATE(p.fecha_partido)

INNER JOIN analytics.dim_torneo tor
    ON tor.torneo_id = p.torneo_id

INNER JOIN analytics.dim_equipo el
    ON el.equipo_id = p.equipo_local

INNER JOIN analytics.dim_equipo ev
    ON ev.equipo_id = p.equipo_visita

LEFT JOIN deportivo.resultados r
    ON r.partido_id = p.id

WHERE p.estado = 'FINALIZADO';