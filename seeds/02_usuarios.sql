-- =====================================
-- USUARIOS DE PRUEBA
-- =====================================
-- El ADMINISTRADOR no se crea aquí: guardar su contraseña en el repositorio (aunque sea un hash)
-- es inseguro. Créalo con el script del backend, que la lee del entorno y la hashea con bcrypt:
--
--   cd StatsHub-Backend
--   $env:ADMIN_EMAIL="admin@statshub.cl"; $env:ADMIN_PASSWORD="<contraseña segura>"; npm run create-admin
--
-- Las cuentas de abajo existen solo para que seeds/04_datos_prueba.sql tenga jugadores y un
-- organizador a los que referenciar. Su password_hash '!sin-acceso' no es un hash bcrypt válido,
-- así que NO pueden iniciar sesión. Para usar alguna, asígnale una contraseña desde la aplicación
-- o con el mismo patrón de create-admin.
--
-- Se puede ejecutar varias veces: los correos existentes no se duplican.

INSERT INTO seguridad.usuarios (nombre, apellido, correo, password_hash, rol_id, activo)
SELECT v.nombre, v.apellido, v.correo, '!sin-acceso', r.id, true
FROM (
    VALUES
        ('Jugador', 'Uno',  'jugador1@statshub.cl',    'JUGADOR'),
        ('Jugador', 'Dos',  'jugador2@statshub.cl',    'JUGADOR'),
        ('Jugador', 'Tres', 'jugador3@statshub.cl',    'JUGADOR'),
        ('Organizador', 'Prueba', 'organizador@statshub.cl', 'ORGANIZADOR')
) AS v(nombre, apellido, correo, rol)
JOIN seguridad.roles r ON r.nombre = v.rol
ON CONFLICT (correo) DO NOTHING;
