-- Categorías deportivas. Se puede ejecutar varias veces: no duplica categorías existentes.
-- (categorias.nombre no tiene restricción UNIQUE, por eso se usa NOT EXISTS en vez de ON CONFLICT.)
INSERT INTO deportivo.categorias(nombre)
SELECT v.nombre
FROM (
    VALUES
        ('Adulto'),
        ('Juvenil'),
        ('Senior'),
        ('Damas')
) AS v(nombre)
WHERE NOT EXISTS (
    SELECT 1 FROM deportivo.categorias c WHERE c.nombre = v.nombre
);
