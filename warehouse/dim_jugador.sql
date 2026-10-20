TRUNCATE TABLE analytics.dim_jugador
RESTART IDENTITY CASCADE;

INSERT INTO analytics.dim_jugador (
    jugador_id,
    nombre_completo,
    posicion
)
SELECT
    j.id,
    CONCAT(u.nombre,' ',u.apellido),
    j.posicion
FROM deportivo.jugadores j
INNER JOIN seguridad.usuarios u
    ON u.id = j.usuario_id;