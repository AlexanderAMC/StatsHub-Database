-- Up Migration
-- Bloqueo temporal de la cuenta tras varios intentos fallidos de inicio de sesión
-- (independiente de la IP: frena la fuerza bruta distribuida sobre una cuenta, p. ej. la del administrador).
ALTER TABLE seguridad.usuarios
    ADD COLUMN intentos_fallidos SMALLINT NOT NULL DEFAULT 0 CONSTRAINT usuarios_intentos_check CHECK (intentos_fallidos >= 0),
    ADD COLUMN bloqueado_hasta TIMESTAMPTZ,
    ADD COLUMN password_cambiado_en TIMESTAMPTZ;

-- Down Migration
ALTER TABLE seguridad.usuarios
    DROP COLUMN IF EXISTS password_cambiado_en,
    DROP COLUMN IF EXISTS bloqueado_hasta,
    DROP COLUMN IF EXISTS intentos_fallidos;
