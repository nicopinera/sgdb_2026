-- SubConsultas
-- SELECCIONAR LOS ACTORES QUE ACTUARON AL MENOS EN UNA PELICULA QUE DURE MENOS DE 70 min
SELECT DISTINCT
    CONCAT(a.first_name, ' ', a.last_name) AS Actor
FROM
    actor a
        JOIN
    film_actor fa ON a.actor_id = fa.actor_id
        JOIN
    film f ON fa.film_id = f.film_id
WHERE
    f.length < 70;
SELECT 
    first_name, last_name
FROM
    actor
WHERE
    70 > ANY (SELECT 
            length
        FROM
            film
                JOIN
            film_actor ON film_actor.film_id = film.film_id
        WHERE
            actor.actor_id = film_actor.actor_id);
-- SELECCIONAR LOS 5 ACTORES QUE MAS TIEMPO ACTUARON SUMANDO LA DURACION DE TODAS SUS PELICULAS
SELECT actor.first_name,
    actor.last_name,
    len.duracion_total
FROM actor,
    (
        SELECT SUM(length) duracion_total,
            actor_id
        FROM film f
            JOIN film_actor fa ON f.film_id = fa.film_id
        GROUP BY fa.actor_id
    ) len
WHERE actor.actor_id = len.actor_id
ORDER BY duracion_total DESC
LIMIT 5;
-- SELECCIONAR LA/S PELICULA/S EN LA QUE ACTUARON MAS ACTORES
select f.film_id,
    f.title,
    cantActores.cantidadAct
from film f,
    (
        select fa.film_id,
            count(*) cantidadAct
        from film_actor fa
        group by fa.film_id
    ) cantActores
where f.film_id = cantActores.film_id
order by cantActores.cantidadAct desc;
-- GENERAR UN LISTADO DE TODOS LOS ACTORES, CANTIDAD DE PELICULAS QUE ACTUARON,  CANTIDAD DE CATEGORIAS, MONTO RECAUDADO (INCLUIR TODOS LOS ACTORES)
select a.actor_id,
    a.first_name,
    a.last_name,
    cant.cantPeliculas,
    categ.cantCategorias,
    recaudacion.totalRecaudado
from actor a,
    (
        select fa.actor_id,
            count(*) as cantPeliculas
        from film_actor fa
        group by fa.actor_id
    ) as cant,
    (
        select fa1.actor_id,
            count(distinct fc.category_id) as cantCategorias
        from film_actor fa1
            left join film_category fc on fa1.film_id = fc.category_id
        group by fa1.actor_id
    ) categ,
    (
        select fa2.actor_id,
            sum(p.amount) as totalRecaudado
        from payment p
            join rental r on r.rental_id = p.rental_id
            join inventory i on i.inventory_id = r.inventory_id
            join film_actor fa2 on fa2.film_id = i.film_id
        group by fa2.actor_id
    ) recaudacion
where cant.actor_id = a.actor_id
    and categ.actor_id = a.actor_id
    and recaudacion.actor_id = a.actor_id;
-- Consultas auxiliares
select fa.actor_id,
    count(*) as cantPeliculas
from film_actor fa
group by fa.actor_id;
-- esta bien
select fa1.actor_id,
    count(distinct fc.category_id) as cantCategorias
from film_actor fa1
    left join film_category fc on fa1.film_id = fc.category_id
group by fa1.actor_id;
select fa2.actor_id,
    sum(p.amount) as totalRecaudado
from payment p
    join rental r on r.rental_id = p.rental_id
    join inventory i on i.inventory_id = r.inventory_id
    join film_actor fa2 on fa2.film_id = i.film_id
group by fa2.actor_id;
-- esta bien
-- MOSTRAR LOS ACTORES QUE ACTUARON EN LA/S PELICULA/S MAS LARGAlength/S
select a.actor_id,
    a.first_name,
    a.last_name,
    tabladuracion.duracion
from actor a,
    (
        select fa.actor_id,
            f.length as duracion
        from film_actor fa
            join film f on fa.film_id = f.film_id
    ) tabladuracion
where tabladuracion.actor_id = a.actor_id
order by tabladuracion.duracion desc;
select fa.actor_id,
    f.length
from film_actor fa
    join film f on fa.film_id = f.film_id;
-- Seleccionar todos los clientes (apellido y nombre) cuyo pagos promedios historicos sean mayores que los pagos promedios de todos los clientes
select c.first_name,
    c.last_name
from customer c
where (
        select avg(amount)
        from payment p
        where c.customer_id = p.customer_id
    ) > (
        select avg(amount)
        from payment
    );
select avg(amount)
from payment;
-- Seleccionar los actores (apellido y nombre) cuyas peliculas hayan sido rentadas al menos una vez en el mes de mayo
select a.first_name,
    a.last_name,
    tablaMayo.rental_date
from actor a,
    (
        select r.rental_date,
            fa.actor_id,
            fa.film_id
        from rental r
            join inventory i on r.inventory_id = i.inventory_id
            join film_actor fa on fa.film_id = i.film_id
        where month(r.rental_date) = '5'
    ) tablaMayo
where a.actor_id = tablaMayo.actor_id;
select r.rental_date,
    fa.actor_id
from rental r
    join inventory i on r.inventory_id = i.inventory_id
    join film_actor fa on fa.film_id = i.film_id
where month(r.rental_date) = '5';
-- Seleccionar el/los actor/es que participo en peliculas de todos las categorias
-- Seleccionar el/los actor/es que participo en peliculas de mas de 3 categorias
-- Seleccionar los clientes que deben retornar videos
-- Mostrar cuantos clientes devovieron un video por fecha
-- Mostar los alquileres que se entregaron fuera de termino, mostrando nombre y apellido del cliente, nombre de la pelicula, y dias de demora