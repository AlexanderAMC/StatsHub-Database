-- Up Migration
-- Integridad referencial y de datos (roadmap P1-2):
--   * Reglas ON DELETE explícitas: CASCADE para datos dependientes, SET NULL para referencias
--     históricas a usuarios (pagos, resultados, jugador vinculado), RESTRICT para lo estructural.
--   * Índices en las FK y columnas de consulta frecuente.
--   * CHECK de rangos, NOT NULL y unicidad que faltaban.

-- ---------- Limpieza previa necesaria para las nuevas restricciones ----------

-- categorias.nombre pasa a ser UNIQUE: si los seeds antiguos (no idempotentes) duplicaron
-- categorías, los torneos se reapuntan a la de menor id y se eliminan los duplicados.
UPDATE deportivo.torneos t
SET categoria_id = d.keep_id
FROM (
    SELECT id, MIN(id) OVER (PARTITION BY nombre) AS keep_id
    FROM deportivo.categorias
) d
WHERE t.categoria_id = d.id AND d.id <> d.keep_id;

DELETE FROM deportivo.categorias c
USING deportivo.categorias k
WHERE c.nombre = k.nombre AND c.id > k.id;

UPDATE seguridad.usuarios SET activo = true WHERE activo IS NULL;
UPDATE seguridad.usuarios SET fecha_creacion = CURRENT_TIMESTAMP WHERE fecha_creacion IS NULL;
UPDATE deportivo.partidos SET estado = 'PROGRAMADO' WHERE estado IS NULL;
UPDATE deportivo.equipo_jugador SET activo = true WHERE activo IS NULL;

-- ---------- ON DELETE ----------

ALTER TABLE deportivo.jugadores
    DROP CONSTRAINT jugadores_usuario_id_fkey,
    ADD CONSTRAINT jugadores_usuario_id_fkey FOREIGN KEY (usuario_id)
        REFERENCES seguridad.usuarios(id) ON DELETE SET NULL;

ALTER TABLE deportivo.equipo_jugador
    DROP CONSTRAINT equipo_jugador_equipo_id_fkey,
    ADD CONSTRAINT equipo_jugador_equipo_id_fkey FOREIGN KEY (equipo_id)
        REFERENCES deportivo.equipos(id) ON DELETE CASCADE,
    DROP CONSTRAINT equipo_jugador_jugador_id_fkey,
    ADD CONSTRAINT equipo_jugador_jugador_id_fkey FOREIGN KEY (jugador_id)
        REFERENCES deportivo.jugadores(id) ON DELETE CASCADE;

ALTER TABLE deportivo.torneo_equipos
    DROP CONSTRAINT torneo_equipos_torneo_id_fkey,
    ADD CONSTRAINT torneo_equipos_torneo_id_fkey FOREIGN KEY (torneo_id)
        REFERENCES deportivo.torneos(id) ON DELETE CASCADE,
    DROP CONSTRAINT torneo_equipos_equipo_id_fkey,
    ADD CONSTRAINT torneo_equipos_equipo_id_fkey FOREIGN KEY (equipo_id)
        REFERENCES deportivo.equipos(id) ON DELETE CASCADE;

-- Un torneo o equipo con partidos no se puede borrar (se cancela/suspende): RESTRICT.
ALTER TABLE deportivo.partidos
    DROP CONSTRAINT partidos_torneo_id_fkey,
    ADD CONSTRAINT partidos_torneo_id_fkey FOREIGN KEY (torneo_id)
        REFERENCES deportivo.torneos(id) ON DELETE RESTRICT,
    DROP CONSTRAINT partidos_equipo_local_fkey,
    ADD CONSTRAINT partidos_equipo_local_fkey FOREIGN KEY (equipo_local)
        REFERENCES deportivo.equipos(id) ON DELETE RESTRICT,
    DROP CONSTRAINT partidos_equipo_visita_fkey,
    ADD CONSTRAINT partidos_equipo_visita_fkey FOREIGN KEY (equipo_visita)
        REFERENCES deportivo.equipos(id) ON DELETE RESTRICT;

ALTER TABLE deportivo.resultados
    DROP CONSTRAINT resultados_partido_id_fkey,
    ADD CONSTRAINT resultados_partido_id_fkey FOREIGN KEY (partido_id)
        REFERENCES deportivo.partidos(id) ON DELETE CASCADE,
    DROP CONSTRAINT resultados_registrado_por_fkey,
    ADD CONSTRAINT resultados_registrado_por_fkey FOREIGN KEY (registrado_por)
        REFERENCES seguridad.usuarios(id) ON DELETE SET NULL;

ALTER TABLE deportivo.eventos_partido
    DROP CONSTRAINT eventos_partido_partido_id_fkey,
    ADD CONSTRAINT eventos_partido_partido_id_fkey FOREIGN KEY (partido_id)
        REFERENCES deportivo.partidos(id) ON DELETE CASCADE,
    DROP CONSTRAINT eventos_partido_jugador_id_fkey,
    ADD CONSTRAINT eventos_partido_jugador_id_fkey FOREIGN KEY (jugador_id)
        REFERENCES deportivo.jugadores(id) ON DELETE SET NULL;

ALTER TABLE deportivo.estadisticas_jugador
    DROP CONSTRAINT estadisticas_jugador_jugador_id_fkey,
    ADD CONSTRAINT estadisticas_jugador_jugador_id_fkey FOREIGN KEY (jugador_id)
        REFERENCES deportivo.jugadores(id) ON DELETE CASCADE;

ALTER TABLE deportivo.notificaciones
    DROP CONSTRAINT notificaciones_usuario_id_fkey,
    ADD CONSTRAINT notificaciones_usuario_id_fkey FOREIGN KEY (usuario_id)
        REFERENCES seguridad.usuarios(id) ON DELETE CASCADE;

-- Los registros financieros se conservan aunque se elimine la cuenta.
ALTER TABLE pagos.transacciones
    DROP CONSTRAINT transacciones_usuario_id_fkey,
    ADD CONSTRAINT transacciones_usuario_id_fkey FOREIGN KEY (usuario_id)
        REFERENCES seguridad.usuarios(id) ON DELETE SET NULL;

-- La bitácora no tenía FK: se añade conservando el registro si se borra el usuario.
UPDATE auditoria.logs l SET usuario_id = NULL
WHERE usuario_id IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM seguridad.usuarios u WHERE u.id = l.usuario_id);
ALTER TABLE auditoria.logs
    ADD CONSTRAINT logs_usuario_id_fkey FOREIGN KEY (usuario_id)
        REFERENCES seguridad.usuarios(id) ON DELETE SET NULL;

-- ---------- NOT NULL, CHECK y UNIQUE ----------

ALTER TABLE seguridad.usuarios
    ALTER COLUMN activo SET NOT NULL,
    ALTER COLUMN fecha_creacion SET NOT NULL;

ALTER TABLE deportivo.categorias
    ADD CONSTRAINT categorias_nombre_key UNIQUE (nombre);

ALTER TABLE deportivo.torneos
    ADD CONSTRAINT torneos_fechas_check CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio);

ALTER TABLE deportivo.equipo_jugador
    ALTER COLUMN activo SET NOT NULL,
    ADD CONSTRAINT equipo_jugador_fechas_check CHECK (fecha_hasta IS NULL OR fecha_hasta >= fecha_desde);

-- Un jugador solo puede estar activo en un equipo a la vez.
CREATE UNIQUE INDEX equipo_jugador_un_activo_por_jugador
    ON deportivo.equipo_jugador (jugador_id) WHERE activo;

ALTER TABLE deportivo.partidos
    ALTER COLUMN estado SET NOT NULL;

ALTER TABLE deportivo.resultados
    ADD CONSTRAINT resultados_goles_check CHECK (goles_local >= 0 AND goles_visita >= 0);

ALTER TABLE deportivo.eventos_partido
    ADD CONSTRAINT eventos_partido_minuto_check CHECK (minuto BETWEEN 0 AND 130);

ALTER TABLE deportivo.estadisticas_jugador
    ADD CONSTRAINT estadisticas_jugador_no_negativas_check
        CHECK (partidos >= 0 AND goles >= 0 AND asistencias >= 0 AND amarillas >= 0 AND rojas >= 0);

ALTER TABLE pagos.transacciones
    ADD CONSTRAINT transacciones_monto_check CHECK (monto IS NULL OR monto >= 0);

-- ---------- Índices ----------

-- Redundante: jugadores.usuario_id ya es UNIQUE (tiene su propio índice).
DROP INDEX IF EXISTS deportivo.idx_jugador_usuario;

CREATE INDEX idx_usuarios_rol ON seguridad.usuarios (rol_id);
CREATE INDEX idx_torneos_categoria ON deportivo.torneos (categoria_id);
CREATE INDEX idx_torneo_equipos_equipo ON deportivo.torneo_equipos (equipo_id);
CREATE INDEX idx_partidos_equipo_local ON deportivo.partidos (equipo_local);
CREATE INDEX idx_partidos_equipo_visita ON deportivo.partidos (equipo_visita);
CREATE INDEX idx_partidos_fecha ON deportivo.partidos (fecha_partido);
CREATE INDEX idx_partidos_torneo_estado ON deportivo.partidos (torneo_id, estado);
CREATE INDEX idx_resultados_registrado_por ON deportivo.resultados (registrado_por);
CREATE INDEX idx_notificaciones_usuario ON deportivo.notificaciones (usuario_id, leida);
CREATE INDEX idx_transacciones_usuario ON pagos.transacciones (usuario_id);
CREATE INDEX idx_logs_usuario ON auditoria.logs (usuario_id);
CREATE INDEX idx_logs_fecha ON auditoria.logs (fecha);
CREATE INDEX idx_fact_partidos_local ON analytics.fact_partidos (equipo_local_id);
CREATE INDEX idx_fact_partidos_visita ON analytics.fact_partidos (equipo_visita_id);


-- Down Migration
DROP INDEX IF EXISTS analytics.idx_fact_partidos_visita;
DROP INDEX IF EXISTS analytics.idx_fact_partidos_local;
DROP INDEX IF EXISTS auditoria.idx_logs_fecha;
DROP INDEX IF EXISTS auditoria.idx_logs_usuario;
DROP INDEX IF EXISTS pagos.idx_transacciones_usuario;
DROP INDEX IF EXISTS deportivo.idx_notificaciones_usuario;
DROP INDEX IF EXISTS deportivo.idx_resultados_registrado_por;
DROP INDEX IF EXISTS deportivo.idx_partidos_torneo_estado;
DROP INDEX IF EXISTS deportivo.idx_partidos_fecha;
DROP INDEX IF EXISTS deportivo.idx_partidos_equipo_visita;
DROP INDEX IF EXISTS deportivo.idx_partidos_equipo_local;
DROP INDEX IF EXISTS deportivo.idx_torneo_equipos_equipo;
DROP INDEX IF EXISTS deportivo.idx_torneos_categoria;
DROP INDEX IF EXISTS seguridad.idx_usuarios_rol;
CREATE INDEX IF NOT EXISTS idx_jugador_usuario ON deportivo.jugadores (usuario_id);

ALTER TABLE pagos.transacciones DROP CONSTRAINT IF EXISTS transacciones_monto_check;
ALTER TABLE deportivo.estadisticas_jugador DROP CONSTRAINT IF EXISTS estadisticas_jugador_no_negativas_check;
ALTER TABLE deportivo.eventos_partido DROP CONSTRAINT IF EXISTS eventos_partido_minuto_check;
ALTER TABLE deportivo.resultados DROP CONSTRAINT IF EXISTS resultados_goles_check;
ALTER TABLE deportivo.partidos ALTER COLUMN estado DROP NOT NULL;
DROP INDEX IF EXISTS deportivo.equipo_jugador_un_activo_por_jugador;
ALTER TABLE deportivo.equipo_jugador
    DROP CONSTRAINT IF EXISTS equipo_jugador_fechas_check,
    ALTER COLUMN activo DROP NOT NULL;
ALTER TABLE deportivo.torneos DROP CONSTRAINT IF EXISTS torneos_fechas_check;
ALTER TABLE deportivo.categorias DROP CONSTRAINT IF EXISTS categorias_nombre_key;
ALTER TABLE seguridad.usuarios
    ALTER COLUMN activo DROP NOT NULL,
    ALTER COLUMN fecha_creacion DROP NOT NULL;

ALTER TABLE auditoria.logs DROP CONSTRAINT IF EXISTS logs_usuario_id_fkey;

-- Restaurar las FK originales (sin regla ON DELETE = NO ACTION)
ALTER TABLE pagos.transacciones
    DROP CONSTRAINT transacciones_usuario_id_fkey,
    ADD CONSTRAINT transacciones_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES seguridad.usuarios(id);
ALTER TABLE deportivo.notificaciones
    DROP CONSTRAINT notificaciones_usuario_id_fkey,
    ADD CONSTRAINT notificaciones_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES seguridad.usuarios(id);
ALTER TABLE deportivo.estadisticas_jugador
    DROP CONSTRAINT estadisticas_jugador_jugador_id_fkey,
    ADD CONSTRAINT estadisticas_jugador_jugador_id_fkey FOREIGN KEY (jugador_id) REFERENCES deportivo.jugadores(id);
ALTER TABLE deportivo.eventos_partido
    DROP CONSTRAINT eventos_partido_partido_id_fkey,
    ADD CONSTRAINT eventos_partido_partido_id_fkey FOREIGN KEY (partido_id) REFERENCES deportivo.partidos(id),
    DROP CONSTRAINT eventos_partido_jugador_id_fkey,
    ADD CONSTRAINT eventos_partido_jugador_id_fkey FOREIGN KEY (jugador_id) REFERENCES deportivo.jugadores(id);
ALTER TABLE deportivo.resultados
    DROP CONSTRAINT resultados_partido_id_fkey,
    ADD CONSTRAINT resultados_partido_id_fkey FOREIGN KEY (partido_id) REFERENCES deportivo.partidos(id),
    DROP CONSTRAINT resultados_registrado_por_fkey,
    ADD CONSTRAINT resultados_registrado_por_fkey FOREIGN KEY (registrado_por) REFERENCES seguridad.usuarios(id);
ALTER TABLE deportivo.partidos
    DROP CONSTRAINT partidos_torneo_id_fkey,
    ADD CONSTRAINT partidos_torneo_id_fkey FOREIGN KEY (torneo_id) REFERENCES deportivo.torneos(id),
    DROP CONSTRAINT partidos_equipo_local_fkey,
    ADD CONSTRAINT partidos_equipo_local_fkey FOREIGN KEY (equipo_local) REFERENCES deportivo.equipos(id),
    DROP CONSTRAINT partidos_equipo_visita_fkey,
    ADD CONSTRAINT partidos_equipo_visita_fkey FOREIGN KEY (equipo_visita) REFERENCES deportivo.equipos(id);
ALTER TABLE deportivo.torneo_equipos
    DROP CONSTRAINT torneo_equipos_torneo_id_fkey,
    ADD CONSTRAINT torneo_equipos_torneo_id_fkey FOREIGN KEY (torneo_id) REFERENCES deportivo.torneos(id),
    DROP CONSTRAINT torneo_equipos_equipo_id_fkey,
    ADD CONSTRAINT torneo_equipos_equipo_id_fkey FOREIGN KEY (equipo_id) REFERENCES deportivo.equipos(id);
ALTER TABLE deportivo.equipo_jugador
    DROP CONSTRAINT equipo_jugador_equipo_id_fkey,
    ADD CONSTRAINT equipo_jugador_equipo_id_fkey FOREIGN KEY (equipo_id) REFERENCES deportivo.equipos(id),
    DROP CONSTRAINT equipo_jugador_jugador_id_fkey,
    ADD CONSTRAINT equipo_jugador_jugador_id_fkey FOREIGN KEY (jugador_id) REFERENCES deportivo.jugadores(id);
ALTER TABLE deportivo.jugadores
    DROP CONSTRAINT jugadores_usuario_id_fkey,
    ADD CONSTRAINT jugadores_usuario_id_fkey FOREIGN KEY (usuario_id) REFERENCES seguridad.usuarios(id);
