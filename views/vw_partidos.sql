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