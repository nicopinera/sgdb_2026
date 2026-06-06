-- 1. Subconsulta como atributo
-- Ejercicio 1.1: Muestra el título de cada película y, en una columna adicional, la cantidad de veces que ha sido alquilada.
SELECT 
    film_id,
    title,
    (SELECT 
            COUNT(*)
        FROM
            rental r
                JOIN
            inventory i ON r.inventory_id = i.inventory_id
        WHERE
            i.film_id = f.film_id) as rentas
FROM
    film f;

select i.film_id,count(*) from rental r join inventory i on r.inventory_id = i.inventory_id group by i.film_id;

-- Ejercicio 1.2: Lista los nombres de los empleados (staff) y, al lado, el total de dinero recaudado en pagos (payment) procesados por cada uno.
SELECT 
    CONCAT(sf.first_name, ' ', sf.last_name) AS 'Nombre Completo',
    (SELECT 
            SUM(p.amount)
        FROM
            payment p
        WHERE
            sf.staff_id = p.staff_id) as ventas
FROM
    staff sf;

select sum(p.amount) from payment p group by p.staff_id;


-- 2. Subconsulta en el FROM
-- Ejercicio 2.1: Encuentra la duración mínima, máxima y promedio de las películas, pero solo considerando aquellas que tienen una clasificación (rating) de 'PG' o 'G'.
SELECT 
    MIN(duracion) AS duracion_minima,
    MAX(duracion) AS duracion_maxima,
    AVG(duracion) AS duracion_promedio
FROM
    (SELECT 
        length AS duracion
    FROM
        film
    WHERE
        rating IN ('PG' , 'G')) AS peliculas_filtradas;

-- Ejercicio 2.2: Obtén el listado de clientes que han realizado más de 30 rentas, usando una subconsulta que cuente las rentas por customer_id antes de filtrar.
SELECT 
    customer_id, total
FROM
    (SELECT 
        customer_id, COUNT(*) AS total
    FROM
        rental
    GROUP BY customer_id) AS sub
WHERE
    total > 30;

-- 3. Subconsulta en el WHERE (IN / NOT IN)
-- Ejercicio 3.1: Obtén los títulos de las películas que no han sido rentadas nunca (usando NOT IN sobre la tabla inventory).
SELECT DISTINCT
    f.title
FROM
    inventory i
        JOIN
    film f ON f.film_id = i.film_id
WHERE
    i.inventory_id NOT IN (SELECT 
            r.inventory_id
        FROM
            rental r);

-- Ejercicio 3.2: Lista las ciudades (city) donde viven clientes cuyo apellido comienza con la letra 'A'.
SELECT 
    ci.city
FROM
    city ci
        JOIN
    address ad ON ci.city_id = ad.city_id
WHERE
    ad.address_id IN (SELECT 
            c.address_id
        FROM
            customer c
        WHERE
            last_name LIKE 'A%');

select last_name from customer c where last_name like  "A%";

-- 4. Subconsulta en el WHERE (EXISTS / NOT EXISTS)
-- Ejercicio 4.1: Selecciona todas las películas (film) que tienen al menos un actor asociado (film_actor).
SELECT 
    *
FROM
    film f
WHERE
    EXISTS( SELECT 
            fa.film_id
        FROM
            film_actor fa
        WHERE
            f.film_id = fa.film_id);


-- Ejercicio 4.2: Encuentra las categorías (category) para las cuales no existe ninguna película asociada.
SELECT 
    ca.name
FROM
    category ca
WHERE
    NOT EXISTS( SELECT 
            fc.film_id
        FROM
            film_category fc
        WHERE
            fc.category_id = ca.category_id);
            
-- 5. Subconsulta en el WHERE (ALL / SOME)
-- Ejercicio 5.1: Muestra las películas cuya duración es mayor que la duración de SOME (alguna) de las películas estrenadas en 2006.
SELECT 
    f.title, f.release_year, f.length
FROM
    film f
WHERE
    f.length > ANY (SELECT 
            f1.length
        FROM
            film f1
        WHERE
            f1.release_year = 2006);
-- Ejercicio 5.2: Encuentra los clientes cuyo monto total de pagos es mayor que el monto total pagado por ALL los clientes que viven en el distrito 'California'.
SELECT 
    c.first_name, c.last_name, SUM(p.amount) AS totalPagado
FROM
    payment p
        JOIN
    customer c ON p.customer_id = c.customer_id
GROUP BY c.customer_id
HAVING totalPagado >= ALL (SELECT 
        SUM(p1.amount)
    FROM
        payment p1
            JOIN
        customer c1 ON p1.customer_id = c1.customer_id
            JOIN
        address ad ON c1.address_id = ad.address_id
    WHERE
        ad.district = 'California'
    GROUP BY c1.customer_id);

select sum(p1.amount) from payment p1 join customer c1 on p1.customer_id = c1.customer_id join address ad on c1.address_id = ad.address_id where ad.district = 'California' group by c1.customer_id;
-- 6. Subconsulta en el GROUP BY
-- Ejercicio 6.1: Clasifica a los clientes según el "rango de cantidad de rentas" (ej: 'Bajo', 'Medio', 'Alto') utilizando una subconsulta que determine el total de rentas por cliente primero.
-- Ejercicio 6.2: Agrupa las películas por el número de actores que tienen (ej: películas con 1-3 actores, 4-6, etc.) contando los actores por película en una subconsulta.

-- 7. Subconsulta en el HAVING
-- Ejercicio 7.1: Muestra las tiendas (store_id) que tienen un inventario total (cantidad de copias de películas) superior al promedio global de inventario por tienda.
-- Ejercicio 7.2: Lista los actores que han participado en más películas que el promedio general de participaciones por actor.