CREATE SCHEMA IF NOT EXISTS auditoria;

CREATE TABLE auditoria.logs(
    id BIGSERIAL PRIMARY KEY,
    usuario_id UUID,
    accion VARCHAR(200),
    tabla_afectada VARCHAR(100),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);