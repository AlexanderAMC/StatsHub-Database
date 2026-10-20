TRUNCATE TABLE analytics.dim_torneo
RESTART IDENTITY CASCADE;

INSERT INTO analytics.dim_torneo (
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