-- Roles del sistema. Se puede ejecutar varias veces: los roles existentes no se duplican.
INSERT INTO seguridad.roles(nombre)
VALUES
('ADMINISTRADOR'),
('ORGANIZADOR'),
('ENTRENADOR'),
('ARBITRO'),
('ESTADIGRAFO'),
('JUGADOR'),
('ESPECTADOR')
ON CONFLICT (nombre) DO NOTHING;
