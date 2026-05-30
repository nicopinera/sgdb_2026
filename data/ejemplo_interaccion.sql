-- Traer todos los datos
SELECT 
    *
FROM
    persona;

-- Traer datos especificos
SELECT 
    *
FROM
    persona
WHERE
    apellido = 'piñera'

-- Actualizar datos
UPDATE persona 
SET 
    apellido = 'bustamante'
WHERE
    dni = 1

-- Eliminar datos
DELETE FROM persona 
WHERE
    dni = 2