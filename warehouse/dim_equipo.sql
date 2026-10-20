TRUNCATE TABLE analytics.dim_equipo
RESTART IDENTITY CASCADE;

INSERT INTO analytics.dim_equipo (
    equipo_id,
    nombre
)
SELECT
    id,
    nombre
FROM deportivo.equipos;