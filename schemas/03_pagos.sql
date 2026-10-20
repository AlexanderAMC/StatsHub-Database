CREATE SCHEMA IF NOT EXISTS pagos;

CREATE TABLE pagos.transacciones(
    id SERIAL PRIMARY KEY,
    usuario_id UUID,
    monto NUMERIC(10,2),
    estado VARCHAR(20),
    flow_id VARCHAR(255),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(usuario_id)
    REFERENCES seguridad.usuarios(id)
);