CREATE OR REPLACE VIEW deportivo.vw_goleadores AS
SELECT
    u.nombre,
    u.apellido,
    e.goles
FROM deportivo.estadisticas_jugador e
INNER JOIN deportivo.jugadores j
    ON j.id = e.jugador_id
INNER JOIN seguridad.usuarios u
    ON u.id = j.usuario_id
ORDER BY e.goles DESC;