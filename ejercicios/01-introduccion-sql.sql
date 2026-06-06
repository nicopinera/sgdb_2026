-- Comando SELECT
SELECT 
    *
FROM
    language;
SELECT 
    *
FROM
    country;
SELECT 
    *
FROM
    city;

-- Comando INSERT: Se utiliza para insertar valores, tiene la siguiente forma:
-- insert into <tabla> (atributo1,atributo2,...) values (valorAtributo1,valorAtributo2), (...,...), ....
-- No puedo saltearme los campos obligatorios, sino me tira error
insert into language (name) values ('Español'),('Guarani');
insert into city (city,country_id) values ('Andorra',87),('Buenos Aires',6);

-- Comando UPDATE: se utiliza para actualizar un valor o valores determinados, si o si se necesita una condicion
-- update <tabla> set atributo1=nuevoValor, atributo2=nuevoValor,... where <condicion|predicado>
UPDATE language 
SET 
    name = 'Portuñol'
WHERE
    language_id = 8;

-- Comando DELETE: se utiliza para borrar un/unos registros
-- delete from <tabla> where <condicion|predicado>
DELETE FROM language 
WHERE
    language_id = 8;

-- Cuando se configuran las FK se configuran las acciones para DELETE o UPDATE
-- 1. Cascade: Cuando elimino el registro en la tabla principal, se elimina en los demas o si se actualiza en la tabla principal, se actualiza en todas las tablas
-- 2. Restrict: Se restringen de eliminar/actualizar el registro principal

-- Comando SELECT: Devuelve una tabla siempre
-- El nombre de la columna es optativo

-- Esto hace un proyeccion.
SELECT 'Hola mundo' AS ho, 9 AS pp;

-- select <atributo> [as <nombreColumna>], <atribtuo2> [as <apodoColumna>], ... from <tabla>; 
-- En los atributos puedo poner operaciones validad de SQL 
SELECT 
    title AS Titulo, rental_rate AS TasaAlquiler
FROM
    film;

-- Para hacer una seleccion o filtrado se utiliza el "where" para establecer una condicion o filtro (predicador)
-- select atributo1,atributo2,... from <tabla1> where <condicion|filtro>
SELECT 
    title AS Titulo, rental_rate AS TasaAlquiler
FROM
    film
WHERE
    rental_rate > 4;

-- No necesariamente tengo que filtrar por atributos que estan en los que yo selecciono para traer
SELECT 
    title AS Titulo, rental_rate AS TasaAqluiler
FROM
    film
WHERE
    (film_id BETWEEN 200 AND 450)
        AND (rental_rate > 3);

-- Para ordenar por algun criterio utilizo "order by" con "asc" para ascendente u "desc" para descendente. Lo que se usa como criterio suelen ser nombres de campos o atributos
-- Para esta sentencia puedo usar los atributos que le puse a las columnas. Por defecto es ascendente. Puedo usar atributos que no estan ahi.
-- El montor no garantiza el orden para una consulta donde no se especifica el "order by"
-- select atributo1,... from <tabla> where <predicado> order by atributo asc|desc
SELECT 
    title AS Titulo, rental_rate AS TasaAqluiler
FROM
    film
WHERE
    (rental_rate > 0.99)
ORDER BY Titulo DESC , film_id ASC;

-- Puedo aplicar un post filtro con la clausula "having", actua solo sobre los atributos que seleccione.
-- Es un filtro que aplico sobre el resultado de la consulta.
SELECT 
    film_id AS id,
    rating,
    title AS Titulo,
    rental_rate AS TasaAqluiler
FROM
    film
WHERE
    (rental_rate > 0.99)
HAVING rating = 'R' OR rating = 'G'
ORDER BY Titulo DESC , film_id ASC;

-- "group by" puedo agrupar por un atributo, no puedo poner en el select atributos que no sean funcionalmente dependientes de la clave de agregacion
-- o resultado de funciones de agregacion (count,  avg, sum, max, min, etc)
-- distinct me trae todos los registros no repetidos, me trae la proyeccion como lo haria el algebra relacional
SELECT DISTINCT
    country_id, COUNT(*) AS CantidadRegistrosPorID
FROM
    city
GROUP BY country_id;

-- Juntas (join): para unir el contenido de una FK con la informacion que esta en la tabla donde es PK
select * from city,country; -- Producto carteciano

select * from city,country where city.country_id = country.country_id; -- Forma primitiva de hacer el join

select ct.city as Ciudad ,co.country as Pais from city as ct
join country as co on ct.country_id = co.country_id;

select city,country from city join country using (country_id); -- forma valida solo cuando tienen el mismo nombre los campos a unir

select f.title as Titulo, f.description as Descripcion, f.rental_duration,f.rental_rate,f.length as Duracion,f.rating as Clasificacion,f.special_features as 'Caracteristicas especiales' , c.name as Descripcion
from film_category as fc
join film as f on  fc.film_id = f.film_id join category as c on fc.category_id=c.category_id;

-- LIKE: es una pequeña expresion regular, se utiliza el %
select city,country from city join country using (country_id) where country LIKE 'A%'; -- Empieza con A
select city,country from city join country using (country_id) where country LIKE '%A%'; -- Contiene con A
select city,country from city join country using (country_id) where country LIKE '%A'; -- Termina con A
select city,country from city join country using (country_id) where country LIKE 'C%A'; -- Empieza con C y Termina con A
select city,country from city join country using (country_id) where country LIKE 'C%D%A'; -- Empieza con C, contiene D y Termina con A

-- SUBCONSULTAS
-- Tanto en SELECT, FROM, WHERE y HAVING se pueden realizar subconsultas. Cuando la subconsulta es en el SELECT el resultado debe ser un valor para colocarlo dentro de los valores que va a tomar el select, tabla 1x1.
-- En el FROM la subconsulta debe dar como resultado una tabla, y darle un nombre a la tabla resultado para poder identificarla (ALIAS). 
-- Tanto en el WHERE y el HAVING me puede devolver un solo registro donde comparo sus valores con los que yo quiero -> (c1,c2,c3) = (select d1,d2,d3 ...)
-- si quiero utilizar mas de un registro, puedo usar operadores como ALL [c1 > ALL (select ...)] lo que hace es comparar el valor con todos los registros de la sub consulta y se tiene que cumplir en todos.
-- Otro caso es utilizar ANY o SOME, que compara el valor con todos los registros de la subconsulta y si la condicion se cumple con al menos uno de los valores, da verdadero.
-- el IN se fija que el valor esta en la lista de valores que trae la subconsulta, si esta da verdadero, sino falso.
-- EXISTS da verdadero si la subconsulta trae algun valor, si trae 0 valores da falso -> WHERE EXISTS (select ...)
-- El SELECT principal se lo llama OUTER (exterior) y a los SELECT que pertenecen a subconsultas se los llama INNER (interior)

SELECT 
    ac.actor_id, ac.first_name, COUNT(*) AS 'TOTAL DE RENTAS'
FROM
    actor ac
        JOIN
    film_actor fa ON fa.actor_id = ac.actor_id
        JOIN
    inventory i ON i.film_id = fa.film_id
        JOIN
    rental r ON r.inventory_id = i.inventory_id
WHERE -- actor_id tiene que estar en la lista de actores que forman parte de los actores en animacion
    ac.actor_id IN (SELECT 
            fa1.actor_id
        FROM
            film_actor fa1
                JOIN
            film_category fc1 ON fc1.film_id = fa1.film_id
                JOIN
            category c1 ON fc1.category_id = c1.category_id
        WHERE
            c1.name = 'Animation'
        GROUP BY fa1.actor_id)
GROUP BY ac.actor_id
HAVING COUNT(*) > 500;

-- forma con el exists
SELECT 
    ac.actor_id, ac.first_name, COUNT(*) AS 'TOTAL DE RENTAS'
FROM
    actor ac
        JOIN
    film_actor fa ON fa.actor_id = ac.actor_id
        JOIN
    inventory i ON i.film_id = fa.film_id
        JOIN
    rental r ON r.inventory_id = i.inventory_id
WHERE -- actor_id tiene que estar en la lista de actores que forman parte de los actores en animacion
    exists (SELECT 
            fa1.actor_id
        FROM
            film_actor fa1
                JOIN
            film_category fc1 ON fc1.film_id = fa1.film_id
                JOIN
            category c1 ON fc1.category_id = c1.category_id
        WHERE
            c1.name = 'Animation' and fa1.actor_id = ac.actor_id
        GROUP BY fa1.actor_id)
GROUP BY ac.actor_id
HAVING COUNT(*) > 500;

-- Listado de actores que actuaron en animacion
select fa1.actor_id from film_actor fa1
join film_category  fc1 on fc1.film_id = fa1.film_id
join category c1 on fc1.category_id = c1.category_id
where c1.name = 'Animation'
group by fa1.actor_id;

-- Obtengo la cantidad de peliculas en las que actuo cada actor
-- Con el ALL obtenemos el mayor de todos los registros
select actor_id,count(*) from film_actor fa
group by actor_id
having count(*) >= ALL (select count(*) from film_actor fa
group by actor_id
);