-- 1) Realizar una consulta donde se listen todos los clientes (customer) con su nombre y apellido, y 
-- sus direcciones, las direcciones deberan mostrar los campos "address" y "address", el nombre de la ciudad y el pais.
create view v_ejercicio_1 as
SELECT c.first_name AS Nombre,
    c.last_name AS Apellido,
    a.address AS Direccion,
    a.district AS Barrio,
    a.postal_code AS CodigoPostal,
    ct.city AS Ciudad,
    ctr.country AS Pais
FROM customer AS c
    JOIN address AS a ON c.address_id = a.address_id
    JOIN city AS ct ON a.city_id = ct.city_id
    JOIN country AS ctr ON ct.country_id = ctr.country_id;
select *
from v_ejercicio_1;
-- 2) Mostrar el listado del punto 1 ordenado por ciudad y pais
SELECT c.first_name AS Nombre,
    c.last_name AS Apellido,
    a.address AS Direccion,
    a.district AS Barrio,
    a.postal_code AS CodigoPostal,
    ct.city AS Ciudad,
    ctr.country AS Pais
FROM customer AS c
    LEFT JOIN address AS a ON c.address_id = a.address_id
    LEFT JOIN city AS ct ON a.city_id = ct.city_id
    LEFT JOIN country AS ctr ON ct.country_id = ctr.country_id
ORDER BY Ciudad ASC,
    Pais ASC;
-- 3) Mostrar el listado del punto anterior agregando una columna con la cantidad de alquileres (rental) por cliente.
SELECT c.first_name AS Nombre,
    c.last_name AS Apellido,
    a.address AS Direccion,
    a.district AS Barrio,
    a.postal_code AS CodigoPostal,
    ct.city AS Ciudad,
    ctr.country AS Pais,
    COUNT(r.customer_id) AS cantidadAlquileres
FROM customer AS c
    LEFT JOIN address AS a ON c.address_id = a.address_id
    LEFT JOIN city AS ct ON a.city_id = ct.city_id
    LEFT JOIN country AS ctr ON ct.country_id = ctr.country_id
    LEFT JOIN rental AS r ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY Ciudad ASC,
    Pais ASC;
-- 4) Mostrar el listado del pto. anterior agregando una columna con el total de pagos hecho por cada cliente, 
-- (no tomar en cuenta el atributo "customer_id" de la tabla "payments")
SELECT c.first_name AS Nombre,
    c.last_name AS Apellido,
    a.address AS Direccion,
    a.district AS Barrio,
    a.postal_code AS CodigoPostal,
    ct.city AS Ciudad,
    ctr.country AS Pais,
    COUNT(distinct r.rental_id) AS cantidadAlquileres,
    SUM(p.amount) AS totalPagado
FROM customer AS c
    LEFT JOIN address AS a ON c.address_id = a.address_id
    LEFT JOIN city AS ct ON a.city_id = ct.city_id
    LEFT JOIN country AS ctr ON ct.country_id = ctr.country_id
    LEFT JOIN rental AS r ON c.customer_id = r.customer_id
    LEFT JOIN payment AS p ON p.rental_id = r.rental_id
GROUP BY c.customer_id
ORDER BY Ciudad ASC,
    Pais ASC;
-- 5 Mostrar el listado del punto anterior dejando solo aquellos registros que correspondan a alquileres 
-- realizados durante el mes de mayo.
SELECT c.first_name AS Nombre,
    c.last_name AS Apellido,
    a.address AS Direccion,
    a.district AS Barrio,
    a.postal_code AS CodigoPostal,
    ct.city AS Ciudad,
    ctr.country AS Pais,
    COUNT(distinct r.customer_id) AS cantidadAlquileres,
    SUM(p.amount) AS totalPagado
FROM customer AS c
    JOIN address AS a ON c.address_id = a.address_id
    JOIN city AS ct ON a.city_id = ct.city_id
    JOIN country AS ctr ON ct.country_id = ctr.country_id
    JOIN rental AS r ON c.customer_id = r.customer_id
    JOIN payment AS p ON p.rental_id = r.rental_id
WHERE MONTH(r.rental_date) = 5
GROUP BY c.customer_id
ORDER BY Ciudad ASC,
    Pais ASC;
-- 6 Mostrar el listado del punto anterior mostrando solo los clientes de ese listado que gastaron mas de 10 pesos.
SELECT c.first_name AS Nombre,
    c.last_name AS Apellido,
    a.address AS Direccion,
    a.district AS Barrio,
    a.postal_code AS CodigoPostal,
    ct.city AS Ciudad,
    ctr.country AS Pais,
    COUNT(distinct r.customer_id) AS cantidadAlquileres,
    SUM(p.amount) AS totalPagado
FROM customer AS c
    JOIN address AS a ON c.address_id = a.address_id
    JOIN city AS ct ON a.city_id = ct.city_id
    JOIN country AS ctr ON ct.country_id = ctr.country_id
    JOIN rental AS r ON c.customer_id = r.customer_id
    JOIN payment AS p ON p.rental_id = r.rental_id
WHERE MONTH(r.rental_date) = 5
GROUP BY c.customer_id
HAVING SUM(p.amount) > 10
ORDER BY Ciudad ASC,
    Pais ASC;
-- 7) Mostrar el listado del punto anterior mostrando solo los 10 clientes de ese listado que mas gastaron.
SELECT c.first_name AS Nombre,
    c.last_name AS Apellido,
    a.address AS Direccion,
    a.district AS Barrio,
    a.postal_code AS CodigoPostal,
    ct.city AS Ciudad,
    ctr.country AS Pais,
    COUNT(distinct r.customer_id) AS cantidadAlquileres,
    SUM(p.amount) AS totalPagado
FROM customer AS c
    JOIN address AS a ON c.address_id = a.address_id
    JOIN city AS ct ON a.city_id = ct.city_id
    JOIN country AS ctr ON ct.country_id = ctr.country_id
    JOIN rental AS r ON c.customer_id = r.customer_id
    JOIN payment AS p ON p.rental_id = r.rental_id
WHERE MONTH(r.rental_date) = 5
GROUP BY c.customer_id
ORDER BY totalPagado DESC
LIMIT 10;