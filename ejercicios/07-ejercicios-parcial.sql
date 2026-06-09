-- 1. Mostrar los datos de los clientes
SELECT 
    c.first_name,
    c.last_name,
    c.email,
    ad.address,
    ad.district,
    ad.postal_code,
    ad.phone,
    ci.city,
    co.country
FROM
    customer c
        LEFT JOIN
    address ad ON ad.address_id = c.address_id
        LEFT JOIN
    city ci ON ad.city_id = ci.city_id
        LEFT JOIN
    country co ON ci.country_id = co.country_id;

-- 2. Mostrar el apellido y nombre de todos los clientes.
SELECT 
    first_name, last_name
FROM
    customer;
 
-- 3. Mostrar el apellido y nombre de los clientes activos
SELECT 
    first_name, last_name
FROM
    customer
WHERE
    active = 1;

-- 4. Mostrar los filmes en los que participó un determinado actor_id
SELECT 
    fi.actor_id, f.title, fi.film_id
FROM
    film_actor fi
        LEFT JOIN
    film f ON f.film_id = fi.film_id
WHERE
    fi.actor_id = 2

-- 5. Mostrar la cantidad de Clientes activos
SELECT 
    COUNT(*) AS cantClientesActivos
FROM
    customer
WHERE
    active = 1

-- 6. Mostrar todas los alquileres de películas realizados entre dos fechas determinadas
SELECT 
    r.rental_id,
    r.rental_date,
    c.first_name,
    c.last_name,
    c.email,
    f.title
FROM
    rental r
        LEFT JOIN
    customer c ON c.customer_id = r.customer_id
        JOIN
    inventory i ON i.inventory_id = r.inventory_id
        JOIN
    film f ON f.film_id = i.film_id
WHERE
    r.rental_date BETWEEN '2005-05-24' AND '2005-05-30'

-- 7. Mostrar la cantidad de alquileres de películas realizadas entre dos fechas determinadas
SELECT 
    COUNT(*)
FROM
    rental
WHERE
    rental_date BETWEEN '2005-05-24' AND '2005-05-25'

-- 8. Mostrar la lista de clientes ordenada alfabéticamente
SELECT 
    first_name, last_name
FROM
    customer
ORDER BY first_name , last_name DESC;

-- 9. Mostrar la cantidad de alquileres que realizó cada cliente (custumer_id)
SELECT 
    r.customer_id, COUNT(r.rental_id)
FROM
    rental r
GROUP BY r.customer_id;

-- 10. Mostrar la cantidad de alquileres de películas realizados por cada cliente entre dos fechas dadas
SELECT 
    r.customer_id, COUNT(r.rental_id)
FROM
    rental r
WHERE
    r.rental_date BETWEEN '2005-05-24' AND '2005-05-30'
GROUP BY r.customer_id;

-- 12. Mostrar todos los lenguajes registrados
SELECT 
    *
FROM
    language;

-- 13. Mostrar las películas de un determinado lenguaje (languaje_id)
SELECT 
    title, description, release_year, la.name
FROM
    film f
        LEFT JOIN
    language la ON f.language_id = la.language_id
WHERE
    f.language_id = 3;

-- 15. ¿Cuál es la fecha del último alquiler registrado en la base de datos?
SELECT 
    MAX(rental_date)
FROM
    rental;-- Fecha mas grande
SELECT 
    MIN(rental_date)
FROM
    rental; -- Fecha mas chica

-- 16. Mostrar el apellido, nombre y dirección de los clientes.
SELECT 
    c.first_name, c.last_name, ad.address
FROM
    customer c
        LEFT JOIN
    address ad ON c.address_id = ad.address_id;

-- 17. Mostrar el apellido, nombre y fecha de alquiler de cada cliente
SELECT 
    c.first_name, c.last_name, r.rental_date
FROM
    rental r
        LEFT JOIN
    customer c ON c.customer_id = r.customer_id
ORDER BY c.first_name , c.last_name , r.rental_date DESC;

-- 18. Mostrar el apellido, nombre y fecha de alquiler de cada cliente realizada entre fechas
SELECT 
    c.first_name, c.last_name, r.rental_date
FROM
    rental r
        LEFT JOIN
    customer c ON c.customer_id = r.customer_id
WHERE
    r.rental_date BETWEEN '2005-05-24' AND '2005-05-30'
ORDER BY c.first_name , c.last_name , r.rental_date DESC;

-- 19. Mostrar el nombre de la película y cantidad de veces que fue alquilada.
SELECT 
    f.title, COUNT(r.rental_id) AS cantRentas
FROM
    rental r
        JOIN
    inventory i ON i.inventory_id = r.inventory_id
        JOIN
    film f ON f.film_id = i.film_id
GROUP BY f.film_id;

-- 20. Mostrar el nombre de las películas que fueron alquiladas más de 15 veces.
SELECT 
    f.title, COUNT(r.rental_id) AS cantRentas
FROM
    rental r
        JOIN
    inventory i ON i.inventory_id = r.inventory_id
        JOIN
    film f ON f.film_id = i.film_id
GROUP BY f.film_id
HAVING cantRentas >= 15
ORDER BY f.title ASC;

-- 21. ¿Cuál es el promedio de amount recaudado por película?
SELECT 
    f.title, AVG(p.amount) AS average_amount
FROM
    payment p
        JOIN
    rental r ON r.rental_id = p.rental_id
        JOIN
    inventory i ON i.inventory_id = r.inventory_id
        JOIN
    film f ON f.film_id = i.film_id
GROUP BY f.film_id;

-- 22. Establecer un ranking de alquileres que muestre las películas más alquiladas
SELECT 
    f.title, COUNT(r.rental_id) AS cantRentas
FROM
    rental r
        JOIN
    inventory i ON i.inventory_id = r.inventory_id
        JOIN
    film f ON f.film_id = i.film_id
GROUP BY f.film_id
ORDER BY cantRentas DESC;

-- 24. ¿Cuántos clientes viven en una ciudad determinada?
SELECT 
    COUNT(*)
FROM
    customer cu
        JOIN
    address ad ON cu.address_id = ad.address_id
        JOIN
    city ci ON ad.city_id = ci.city_id
WHERE
    ci.city = 'Simferopol'
GROUP BY ci.city_id;
SELECT 
    ci.city, COUNT(DISTINCT cu.customer_id)
FROM
    customer cu
        JOIN
    address ad ON cu.address_id = ad.address_id
        JOIN
    city ci ON ad.city_id = ci.city_id
GROUP BY ci.city_id;

-- 25. ¿Cuántos ejemplares hay de cada película?
SELECT 
    f.title, COUNT(i.inventory_id) AS cantCopias
FROM
    inventory i
        JOIN
    film f ON i.film_id = f.film_id
GROUP BY f.film_id
ORDER BY cantCopias DESC;

-- 26. Listá todos los actores (nombre y apellido) junto con el título de cada película en la que participaron. Incluí actores que no tienen películas asignadas.
SELECT 
    a.first_name, a.last_name, f.title
FROM
    actor a
        LEFT JOIN
    film_actor fa ON a.actor_id = fa.actor_id
        LEFT JOIN
    film f ON f.film_id = fa.film_id;

-- 27. Mostrá el nombre de cada película (film.title), la categoría a la que pertenece (category.name) y el nombre de la tienda (store_id) que tiene copias en inventario. 
-- Ordená por categoría y luego por título.
SELECT DISTINCT
    f.title, c.name, s.store_id
FROM
    inventory i
        JOIN
    film f ON i.film_id = f.film_id
        JOIN
    store s ON s.store_id = i.store_id
        JOIN
    film_category fc ON fc.film_id = f.film_id
        JOIN
    category c ON c.category_id = fc.category_id
ORDER BY fc.category_id , f.title;

-- 28. Listá todos los empleados (staff) con su nombre, apellido, dirección completa (address, city, country) y el nombre de la tienda donde trabajan. 
-- Usá LEFT JOINs en toda la cadena.
SELECT 
    st.first_name, st.last_name, ad.address, ci.city, co.country
FROM
    staff st
        LEFT JOIN
    address ad ON st.address_id = ad.address_id
        LEFT JOIN
    city ci ON ci.city_id = ad.city_id
        LEFT JOIN
    country co ON co.country_id = ci.country_id;
    
-- 29. Mostrá todos los alquileres (rental) realizados incluyendo: fecha de alquiler, nombre del cliente, título de la película alquilada y nombre del empleado que lo gestionó. 
-- Ordená por fecha de alquiler descendente.
SELECT 
    re.rental_id,
    re.rental_date,
    c.first_name,
    f.title,
    st.first_name
FROM
    rental re
        JOIN
    customer c ON re.customer_id = c.customer_id
        JOIN
    inventory i ON i.inventory_id = re.inventory_id
        JOIN
    film f ON f.film_id = i.film_id
        JOIN
    staff st ON st.staff_id = re.staff_id
ORDER BY re.rental_date ASC;

-- 30. Listá todas las películas que nunca fueron alquiladas (no tienen registros en inventory o sus copias jamás generaron un rental). Mostrá título y categoría. 
-- Pista: pensá cómo el LEFT JOIN expone los NULLs
SELECT 
    f.title, ca.name
FROM
    film f
        LEFT JOIN
    inventory i ON f.film_id = i.film_id
        LEFT JOIN
    rental r ON r.inventory_id = i.inventory_id
        JOIN
    film_category fc ON fc.film_id = f.film_id
        JOIN
    category ca ON ca.category_id = fc.category_id
WHERE
    r.rental_id IS NULL;

-- 31. Para cada categoría de film, mostrá la cantidad de films que tiene y el promedio de duración (film.length). Ordená de mayor a menor por cantidad de films.
SELECT 
    c.name,
    COUNT(DISTINCT f.film_id) AS cantPeliculas,
    AVG(f.length) AS promDuracion
FROM
    category c
        JOIN
    film_category fc ON c.category_id = fc.category_id
        JOIN
    film f ON f.film_id = fc.film_id
GROUP BY c.name
ORDER BY c.name , cantPeliculas DESC;

-- 32. Mostrá los 5 actores que aparecen en más películas. Columnas: nombre, apellido, cantidad de films. Excluí actores con menos de 20 películas usando HAVING.
SELECT 
    a.first_name,
    a.last_name,
    COUNT(DISTINCT fa.film_id) AS cantPeliculas
FROM
    actor a
        JOIN
    film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id
HAVING cantPeliculas > 20
ORDER BY cantPeliculas DESC
LIMIT 5;

-- 33. Para cada tienda (store_id), calculá el total recaudado por año (YEAR(payment_date)) y mes. Ordená por tienda, año y mes.
SELECT 
    st.store_id,
    YEAR(p.payment_date),
    MONTH(p.payment_date),
    AVG(p.amount)
FROM
    store st
        JOIN
    staff sa ON sa.store_id = st.store_id
        JOIN
    payment p ON p.staff_id = sa.staff_id
GROUP BY st.store_id , YEAR(payment_date) , MONTH(payment_date);

-- 34. Listá los clientes que realizaron más de 30 alquileres en total. Mostrá nombre, apellido y cantidad de alquileres.
SELECT 
    c.first_name, c.last_name, COUNT(r.rental_id) AS cantRentas
FROM
    customer c
        JOIN
    rental r ON r.customer_id = c.customer_id
GROUP BY c.customer_id
HAVING cantRentas > 30;

-- 35. Para cada empleado (staff), mostrá la cantidad de alquileres que gestionó y el monto total de pagos asociados a esos alquileres. Filtrá solo los del año 2005.
SELECT 
    st.first_name,
    st.last_name,
    COUNT(DISTINCT p.rental_id) AS cantVentas,
    SUM(p.amount) AS cantRecaudada
FROM
    staff st
        JOIN
    payment p ON st.staff_id = p.staff_id
WHERE
    YEAR(p.payment_date) = 2005
GROUP BY st.staff_id;

-- 36. Mostrá las 3 películas más rentables (mayor SUM de payments). Columnas: título, categoría, total recaudado.
SELECT 
    f.title,
    COUNT(DISTINCT r.rental_id) AS cantRentas,
    SUM(p.amount) AS totalRecaudado
FROM
    film f
        JOIN
    inventory i ON f.film_id = i.film_id
        JOIN
    rental r ON r.inventory_id = i.inventory_id
        JOIN
    payment p ON p.rental_id = r.rental_id
GROUP BY f.film_id
ORDER BY cantRentas DESC
LIMIT 3;

-- #######################################################################SELECT 
    ca.name, cou.country, COUNT(r.rental_id) AS cantRentas
FROM
    rental r
        LEFT JOIN
    inventory i ON i.inventory_id = r.inventory_id
        LEFT JOIN
    film_category fc ON fc.film_id = i.film_id
        LEFT JOIN
    category ca ON ca.category_id = fc.category_id
        LEFT JOIN
    customer c ON c.customer_id = r.customer_id
        LEFT JOIN
    address ad ON ad.address_id = c.address_id
        LEFT JOIN
    city ci ON ci.city_id = ad.city_id
        LEFT JOIN
    country cou ON cou.country_id = ci.country_id
WHERE
    r.rental_date BETWEEN '2005-05-24' AND '2005-08-30'
GROUP BY ca.name , cou.country
ORDER BY cantRentas DESCtes de "Brasil"
SELECT 
    ca.name, cou.country, COUNT(r.rental_id) AS cantRentas
FROM
    rental r
        LEFT JOIN
    inventory i ON i.inventory_id = r.inventory_id
        LEFT JOIN
    film_category fc ON fc.film_id = i.film_id
        LEFT JOIN
    category ca ON ca.category_id = fc.category_id
        LEFT JOIN
    customer c ON c.customer_id = r.customer_id
        LEFT JOIN
    address ad ON ad.address_id = c.address_id
        LEFT JOIN
    city ci ON ci.city_id = ad.city_id
        LEFT JOIN
    country cou ON cou.country_id = ci.country_id
WHERE cou.country = 'India'
GROUP BY ca.name , cou.country
ORDER BY cantRentas DESC;

-- 3. Mostrar todos los clientes que no hayan alquilado nunca una película de "Horror"
SELECT 
    *
FROM
    customer c
WHERE
    c.customer_id NOT IN (SELECT DISTINCT
            r.customer_id
        FROM
            rental r
                JOIN
            inventory i ON i.inventory_id = r.inventory_id
                JOIN
            film_category fc ON fc.film_id = i.film_id
                JOIN
            category ca ON ca.category_id = fc.category_id
        WHERE
            ca.name = 'Horror');


-- 4. ¿Cuáles son las categorías que se alquilaron mas que la categoría Family?
SELECT 
    ca.name, COUNT(DISTINCT r.rental_id) AS cantRentas
FROM
    rental r
        JOIN
    inventory i ON i.inventory_id = r.inventory_id
        JOIN
    film_category fc ON fc.film_id = i.film_id
        JOIN
    category ca ON ca.category_id = fc.category_id
GROUP BY ca.name
HAVING cantRentas > (SELECT 
        COUNT(DISTINCT r.rental_id)
    FROM
        rental r
            JOIN
        inventory i ON i.inventory_id = r.inventory_id
            JOIN
        film_category fc ON fc.film_id = i.film_id
            JOIN
        category ca ON ca.category_id = fc.category_id
    WHERE
        ca.name = 'Family')
;

-- Consulta que trae la cantidad de rentas de una categoria
SELECT 
    COUNT(DISTINCT r.rental_id)
FROM
    rental r
        JOIN
    inventory i ON i.inventory_id = r.inventory_id
        JOIN
    film_category fc ON fc.film_id = i.film_id
        JOIN
    category ca ON ca.category_id = fc.category_id
    where ca.name = 'Family';

-- 5. Mostrar las categorías que hayan realizado menos alquileres que las categorías "Horror", "Games" y "Family"
SELECT 
    ca.name, COUNT(DISTINCT r.rental_id) AS cantRentas
FROM
    rental r
        JOIN
    inventory i ON i.inventory_id = r.inventory_id
        JOIN
    film_category fc ON fc.film_id = i.film_id
        JOIN
    category ca ON ca.category_id = fc.category_id
GROUP BY ca.name
HAVING cantRentas < ALL (SELECT 
        COUNT(DISTINCT r.rental_id)
    FROM
        rental r
            JOIN
        inventory i ON i.inventory_id = r.inventory_id
            JOIN
        film_category fc ON fc.film_id = i.film_id
            JOIN
        category ca ON ca.category_id = fc.category_id
    WHERE
        ca.name IN ('Horror' , 'Games', 'Family')
    GROUP BY ca.name);

-- lista de cantidad de rentas de cada categoria
SELECT 
    COUNT(DISTINCT r.rental_id)
FROM
    rental r
        JOIN
    inventory i ON i.inventory_id = r.inventory_id
        JOIN
    film_category fc ON fc.film_id = i.film_id
        JOIN
    category ca ON ca.category_id = fc.category_id
WHERE
    ca.name IN ('Horror' , 'Games', 'Family')
GROUP BY ca.name;

-- 6. Mostrar el nombre de los clientes que realizaron alquileres de películas en todas las categorías
SELECT 
    c.first_name, c.last_name
FROM
    customer c
        JOIN
    rental r ON r.customer_id = c.customer_id
        JOIN
    inventory i ON i.inventory_id = r.inventory_id
        JOIN
    film_category fc ON fc.film_id = i.film_id
GROUP BY c.customer_id
HAVING COUNT(DISTINCT fc.category_id) = (SELECT 
        COUNT(*)
    FROM
        category);

-- 7. ¿Existen clientes que alquilaran mas de una vez una misma película?
SELECT 
    c.customer_id, i.film_id, COUNT(*)
FROM
    customer c
        JOIN
    rental r ON r.customer_id = c.customer_id
        JOIN
    inventory i ON i.inventory_id = r.inventory_id
GROUP BY c.customer_id , i.film_id
HAVING COUNT(*) > 1;

-- 8. Mostrar el ranking de películas alquiladas, por cada vendedor.
SELECT 
    st.first_name,
    st.last_name,
    f.title,
    COUNT(DISTINCT r.rental_id) AS cantRentas
FROM
    rental r
        JOIN
    inventory i ON i.inventory_id = r.inventory_id
        JOIN
    staff st ON st.staff_id = r.staff_id
        JOIN
    film f ON f.film_id = i.film_id
GROUP BY r.staff_id , i.film_id
ORDER BY st.staff_id , cantRentas DESC;

-- 10. Mostrar los clientes que nunca hayan alquilado películas protagonizadas por los actores “Swank” y  ”Cage”.
SELECT 
    *
FROM
    customer c
WHERE
    c.customer_id NOT IN (SELECT DISTINCT
            r.customer_id
        FROM
            rental r
                JOIN
            inventory i ON r.inventory_id = i.inventory_id
                JOIN
            film_actor fa ON fa.film_id = i.film_id
                JOIN
            actor a ON a.actor_id = fa.actor_id
        WHERE
            a.last_name = 'Swank'
                OR a.last_name = 'Cage')
;
SELECT DISTINCT
    r.customer_id
FROM
    rental r
        JOIN
    inventory i ON r.inventory_id = i.inventory_id
        JOIN
    film_actor fa ON fa.film_id = i.film_id
        JOIN
    actor a ON a.actor_id = fa.actor_id
WHERE
    a.last_name = 'Swank'
        OR a.last_name = 'Cage';

-- Seleccioná los actores (nombre y apellido) cuyas películas hayan sido rentadas al menos una vez en el mes de junio. No uses DISTINCT, usá GROUP BY.
SELECT 
    a.first_name, a.last_name
FROM
    actor a
WHERE
    a.actor_id IN (SELECT 
            fa.actor_id
        FROM
            rental r
                JOIN
            inventory i ON i.inventory_id = r.inventory_id
                JOIN
            film_actor fa ON fa.film_id = i.film_id
        WHERE
            MONTH(r.rental_date) = 6
        GROUP BY fa.actor_id
        HAVING COUNT(*) >= 1);

SELECT 
    fa.actor_id
FROM
    rental r
        LEFT JOIN
    inventory i ON i.inventory_id = r.inventory_id
        LEFT JOIN
    film_actor fa ON fa.film_id = i.film_id
WHERE
    MONTH(r.rental_date) = 6
GROUP BY fa.actor_id
HAVING COUNT(*) > 1;

-- otra forma de resolverlo
SELECT 
    a.first_name, a.last_name, COUNT(DISTINCT r.rental_id)
FROM
    actor a
        JOIN
    film_actor fa ON fa.actor_id = a.actor_id
        JOIN
    inventory i ON i.film_id = fa.film_id
        JOIN
    rental r ON r.inventory_id = i.inventory_id
WHERE
    MONTH(r.rental_date) = 6
GROUP BY a.actor_id;

-- Seleccioná los actores que participaron en films de más de 5 categorías distintas. Mostrá nombre, apellido y cantidad de categorías. Ordená de mayor a menor.
SELECT 
    a.first_name,
    a.last_name,
    (SELECT 
            COUNT(DISTINCT fc.category_id)
        FROM
            film_category fc
                JOIN
            film_actor fa ON fc.film_id = fa.film_id
        WHERE
            fa.actor_id = a.actor_id) AS cantCategoriasDistintas
FROM
    actor a
HAVING cantCategoriasDistintas > 10
ORDER BY cantCategoriasDistintas DESC;

-- sub consulta
SELECT 
    COUNT(DISTINCT fc.category_id)
FROM
    film_category fc
        JOIN
    film_actor fa ON fc.film_id = fa.film_id
WHERE
    fa.actor_id = 1;

-- forma sin subconsulta
SELECT 
    a.first_name,
    a.last_name,
    COUNT(DISTINCT fc.category_id) AS cantCategoriasDistintas
FROM
    actor a
        JOIN
    film_actor fa ON a.actor_id = fa.actor_id
        JOIN
    film_category fc ON fa.film_id = fc.film_id
GROUP BY a.actor_id
HAVING COUNT(DISTINCT fc.category_id) > 5
ORDER BY cantCategoriasDistintas DESC;

-- Para cada actor, mostrá: apellido, cantidad de films que superaron la recaudación promedio de todos los films, cantidad de categorías distintas de sus films, y cantidad total de alquileres de sus films.
SELECT 
    a.actor_id,
    a.last_name,
    (SELECT 
            COUNT(*)
        FROM
            (SELECT 
                i2.film_id, SUM(p2.amount) AS totalRecaudado
            FROM
                payment p2
            JOIN rental r2 ON p2.rental_id = r2.rental_id
            JOIN inventory i2 ON i2.inventory_id = r2.inventory_id
            JOIN film_actor fa2 ON fa2.film_id = i2.film_id
            WHERE
                fa2.actor_id = a.actor_id
            GROUP BY i2.film_id) recaudacion_pelica_actor
        WHERE
            totalRecaudado > (SELECT 
                    AVG(totalRecaudadoPorPelicula)
                FROM
                    (SELECT 
                        SUM(p1.amount) AS totalRecaudadoPorPelicula
                    FROM
                        payment p1
                    JOIN rental r1 ON r1.rental_id = p1.rental_id
                    JOIN inventory i1 ON r1.inventory_id = i1.inventory_id
                    GROUP BY i1.film_id) tabla_totales)) AS cantPeliculasSuperaPromedio,
    (SELECT 
            COUNT(DISTINCT fc3.category_id)
        FROM
            film_actor fa3
                JOIN
            film_category fc3 ON fa3.film_id = fc3.film_id
        WHERE
            fa3.actor_id = a.actor_id) AS cantCategoriasDistintas,
    (SELECT 
            COUNT(r4.rental_id)
        FROM
            rental r4
                JOIN
            inventory i4 ON r4.inventory_id = i4.inventory_id
                JOIN
            film_actor fa4 ON fa4.film_id = i4.film_id
        WHERE
            fa4.actor_id = a.actor_id) AS cantRentas
FROM
    actor a;

-- sub consulta 1
-- Obtengo la suma de lo que recaudo cada film
SELECT 
    SUM(p1.amount) AS totalRecaudadoPorPelicula
FROM
    payment p1
        JOIN
    rental r1 ON r1.rental_id = p1.rental_id
        JOIN
    inventory i1 ON r1.inventory_id = i1.inventory_id
GROUP BY i1.film_id;
-- obtengo el promedio que recauda una pelicula
SELECT
    AVG(totalRecaudadoPorPelicula)
FROM
    (SELECT 
        SUM(p1.amount) AS totalRecaudadoPorPelicula
    FROM
        payment p1
    JOIN rental r1 ON r1.rental_id = p1.rental_id
    JOIN inventory i1 ON r1.inventory_id = i1.inventory_id
    GROUP BY i1.film_id) tabla_totales;
-- obtengo el total que recaudo cada pelicula del actor
SELECT 
    i2.film_id, SUM(p2.amount)
FROM
    payment p2
        JOIN
    rental r2 ON p2.rental_id = r2.rental_id
        JOIN
    inventory i2 ON i2.inventory_id = r2.inventory_id
        JOIN
    film_actor fa2 ON fa2.film_id = i2.film_id
WHERE
    fa2.actor_id = 2
GROUP BY i2.film_id;

-- obtenemos la cantidad de peliculas que superan el promedio
SELECT 
    COUNT(*)
FROM
    (SELECT 
        i2.film_id, SUM(p2.amount) AS totalRecaudado
    FROM
        payment p2
    JOIN rental r2 ON p2.rental_id = r2.rental_id
    JOIN inventory i2 ON i2.inventory_id = r2.inventory_id
    JOIN film_actor fa2 ON fa2.film_id = i2.film_id
    WHERE
        fa2.actor_id = 3
    GROUP BY i2.film_id) recaudacion_pelica_actor
WHERE
    totalRecaudado > (SELECT 
            AVG(totalRecaudadoPorPelicula)
        FROM
            (SELECT 
                SUM(p1.amount) AS totalRecaudadoPorPelicula
            FROM
                payment p1
            JOIN rental r1 ON r1.rental_id = p1.rental_id
            JOIN inventory i1 ON r1.inventory_id = i1.inventory_id
            GROUP BY i1.film_id) tabla_totales);

-- sub consulta 2
SELECT 
    COUNT(DISTINCT fc.category_id)
FROM
    film_actor fa
        JOIN
    film_category fc ON fa.film_id = fc.film_id
WHERE
    fa.actor_id = 2;

-- sub consulta 3
SELECT 
    COUNT(r3.rental_id)
FROM
    rental r3
        JOIN
    inventory i3 ON r3.inventory_id = i3.inventory_id
        JOIN
    film_actor fa3 ON fa3.film_id = i3.film_id
WHERE
    fa3.actor_id = 1;

-- Listá los clientes que tienen pagos pendientes: alquileres sin return_date donde la fecha de devolución esperada (rental_date + rental_duration) ya pasó. 
-- Mostrá nombre, apellido, título del film y días de atraso.
SELECT 
    c.first_name,
    c.last_name,
    f.title,
    DATEDIFF(NOW(), r.rental_date) AS diasRetraso
FROM
    rental r
        JOIN
    inventory i ON i.inventory_id = r.inventory_id
        JOIN
    film f ON f.film_id = i.film_id
        JOIN
    customer c ON c.customer_id = r.customer_id
WHERE
    return_date IS NULL
        AND DATEDIFF(NOW(), r.rental_date) > f.rental_duration;

select r1.rental_date, datediff(now(),r1.rental_date) from rental r1 join inventory i1 on i1.inventory_id = r1.inventory_id join film f1 on f1.film_id = i1.film_id;

-- Generá el reporte de performance por tienda, empleado y film: una fila por cada combinación válida (store, staff, film) con cantidad de alquileres y recaudación. 
-- Los nulos deben ser 0.
SELECT 
    store.store_id,
    st.first_name,
    st.last_name,
    f.film_id,
    f.title,
    COUNT(r.rental_id) as cantAlquileres,
    SUM(p.amount) as totalRecaudado
FROM
    rental r
        LEFT JOIN
    payment p ON p.rental_id = r.rental_id
        LEFT JOIN
    staff st ON st.staff_id = r.staff_id
        LEFT JOIN
    store ON store.store_id = st.store_id
        LEFT JOIN
    inventory i ON r.inventory_id = i.inventory_id
        LEFT JOIN
    film f ON f.film_id = i.film_id
GROUP BY store.store_id , st.staff_id , f.film_id;

-- Seleccioná el/los film/s cuya recaudación es la máxima dentro de su categoría. Mostrá título, categoría y monto. Puede haber empates
SELECT 
    f.title, c.name, SUM(p.amount)
FROM
    film f
        JOIN
    film_category fc ON fc.film_id = f.film_id
        JOIN
    category c ON c.category_id = fc.category_id
        JOIN
    inventory i ON i.film_id = f.film_id
        JOIN
    rental r ON r.inventory_id = i.inventory_id
        JOIN
    payment p ON p.rental_id = r.rental_id
GROUP BY c.name , f.film_id
HAVING SUM(p.amount) >= ALL (SELECT 
        SUM(p1.amount)
    FROM
        category c1
            JOIN
        film_category fc1 ON fc1.category_id = c1.category_id
            JOIN
        inventory i1 ON i1.film_id = fc1.film_id
            JOIN
        rental r1 ON r1.inventory_id = i1.inventory_id
            JOIN
        payment p1 ON p1.rental_id = r1.rental_id
    WHERE
        c1.name = c.name
    GROUP BY fc1.film_id);

SELECT 
    SUM(p1.amount)
FROM
    category c1
        JOIN
    film_category fc1 ON fc1.category_id = c1.category_id
        JOIN
    inventory i1 ON i1.film_id = fc1.film_id
        JOIN
    rental r1 ON r1.inventory_id = i1.inventory_id
        JOIN
    payment p1 ON p1.rental_id = r1.rental_id
WHERE
    c1.name = 'Horror'
GROUP BY fc1.film_id;

-- ############################################################################################
-- ############################################################################################
-- ############################################################################################

-- EJERCICIO 1.
-- Recupere de la base de datos un listado de todos las películas que tienen mas copias en el inventario que el promedio de las películas.
-- De cada película en el listado deberá indicar:
-- NOMBRE DE LA PELÍCULA
-- CANTIDAD DE ACTORES QUE ACTÚAN
-- CANTIDAD TOTAL DE ALQUILERES QUE SE REALIZARON DE ESA PELÍCULA
-- CANTIDAD DE ALQUILERES NO DEVUELTOS DE ESA PELICULA
SELECT 
    f.title,
    (SELECT 
            COUNT(DISTINCT fa1.actor_id)
        FROM
            film_actor fa1
        WHERE
            fa1.film_id = f.film_id) AS cantActores,
    (SELECT 
            COUNT(r2.rental_id)
        FROM
            rental r2
                JOIN
            inventory i2 ON i2.inventory_id = r2.inventory_id
        WHERE
            i2.film_id = f.film_id) AS cantAlquileres,
    (SELECT 
            COUNT(r3.rental_id)
        FROM
            rental r3
                JOIN
            inventory i3 ON r3.inventory_id = i3.inventory_id
        WHERE
            i3.film_id = f.film_id
                AND r3.return_date IS NULL) AS cantAlquileresNoDevueltos
FROM
    film f
        JOIN
    inventory i ON i.film_id = f.film_id
GROUP BY f.film_id
HAVING COUNT(i.inventory_id) >= (SELECT 
        COUNT(i1.inventory_id) / COUNT(DISTINCT i1.film_id) AS promCopias
    FROM
        inventory i1);

-- Promedio de copias por pelicula
SELECT 
    COUNT(i1.inventory_id) / COUNT(DISTINCT i1.film_id) AS promCopias
FROM
    inventory i1;

select count(i2.inventory_id) as cantPeliculas from inventory i2 group by i2.film_id;
select avg(aux1.cantPeliculas) from (select count(i2.inventory_id) as cantPeliculas from inventory i2 group by i2.film_id) as aux1;

-- Cantidad actores por pelicula
SELECT 
    COUNT(DISTINCT fa1.actor_id)
FROM
    film_actor fa1
WHERE
    fa1.film_id = 1;

-- Cantidad total de alquileres de una pelicula
SELECT 
    COUNT(r2.rental_id)
FROM
    rental r2
        JOIN
    inventory i2 ON i2.inventory_id = r2.inventory_id
WHERE
    i2.film_id = 1;

SELECT 
    COUNT(r3.rental_id)
FROM
    rental r3
        JOIN
    inventory i3 ON r3.inventory_id = i3.inventory_id
WHERE
    i3.film_id = 3
        AND r3.return_date IS NULL;

-- ############################################################################################
-- ############################################################################################
-- ############################################################################################
-- EJERCICIO 2.
-- Por cada combinación categoría - actor indicar:
-- Nombre de la categoría,
-- Nombre y apellido del actor
-- Cuantos alquileres se realizaron de cada categoría por películas de cada actor,
-- Se debe producir un registro para cada una de las combinaciones actor categoría (producto cartesiano)
SELECT 
    c.name,
    a.first_name,
    a.last_name,
    (SELECT 
            COUNT(*)
        FROM
            rental r
                LEFT JOIN
            inventory i ON i.inventory_id = r.inventory_id
                LEFT JOIN
            film_category fc ON fc.film_id = i.film_id
                LEFT JOIN
            film_actor fa ON fa.film_id = fc.film_id
        WHERE
            fa.actor_id = a.actor_id
                AND fc.category_id = c.category_id) AS cantAlquileres
FROM
    actor AS a,
    category AS c;

SELECT 
    COUNT(*)
FROM
    rental r
        JOIN
    inventory i ON i.inventory_id = r.inventory_id
        JOIN
    film_category fc ON fc.film_id = i.inventory_id
        JOIN
    film_actor fa ON fa.film_id = fc.film_id
WHERE
    fa.actor_id = 1 AND fc.category_id =3;

--

SELECT 
    c.name, a.first_name, a.last_name, aux.cant
FROM
    actor AS a
        JOIN
    (SELECT 
        fa.actor_id, fc.category_id, COUNT(*) AS cant
    FROM
        rental r
    JOIN inventory i ON i.inventory_id = r.inventory_id
    JOIN film_category fc ON fc.film_id = i.film_id
    JOIN film_actor fa ON fa.film_id = fc.film_id
    GROUP BY fa.actor_id , fc.category_id) AS aux ON aux.actor_id = a.actor_id
        JOIN
    category c ON c.category_id = aux.category_id;

-- ############################################################################################
-- ############################################################################################
-- ############################################################################################
-- EJERCICIO 3.
-- Recupere la actuacion de los clientes generando un listado de los clientes, cada renglon del listado debera contener:
-- Apellido del cliente
-- Nombre del cliente
-- Monto total de pagos realizado
-- Mes y año en el que ese cliente pago mas por todos los alquileres del mes, si hay mas de uno mayor mostrar solo 1
-- Cantidad de alquileres que realizo en ese mes y año
-- Solo mostrar los clientes que tengan al menos un alquiler no devuelto
-- Ordenar por monto total decendente

SELECT 
    c.last_name,
    c.first_name,
    (SELECT 
            SUM(p1.amount)
        FROM
            payment p1
        WHERE
            p1.customer_id = c.customer_id) AS montoTotal,
    aux2.anio2,
    aux2.mes2,
    (SELECT 
            COUNT(*)
        FROM
            rental r4
        WHERE
            r4.customer_id = c.customer_id
                AND MONTH(r4.rental_date) = aux2.mes2
                AND YEAR(r4.rental_date) = aux2.anio2) AS cantAlquileres
FROM
    customer c
        JOIN
    (SELECT 
        aux1.customer_id, aux1.anio AS anio2, aux1.mes AS mes2
    FROM
        (SELECT 
        r.customer_id,
            YEAR(r.rental_date) AS anio,
            MONTH(r.rental_date) AS mes,
            SUM(p.amount) AS total_mes
    FROM
        payment p
    JOIN rental r ON p.rental_id = r.rental_id
    GROUP BY r.customer_id , YEAR(r.rental_date) , MONTH(r.rental_date)) aux1
    JOIN (SELECT 
        customer_id, MAX(total_mes) AS max_pago
    FROM
        (SELECT 
        r.customer_id,
            YEAR(r.rental_date) AS anio,
            MONTH(r.rental_date) AS mes,
            SUM(p.amount) AS total_mes
    FROM
        payment p
    JOIN rental r ON p.rental_id = r.rental_id
    GROUP BY r.customer_id , YEAR(r.rental_date) , MONTH(r.rental_date)) aux1_copia
    GROUP BY customer_id) maximos ON maximos.customer_id = aux1.customer_id
        AND maximos.max_pago = aux1.total_mes) aux2 ON aux2.customer_id = c.customer_id
WHERE
    c.customer_id IN (SELECT DISTINCT
            r5.customer_id
        FROM
            rental r5
        WHERE
            r5.return_date IS NULL)
ORDER BY montoTotal DESC;

select distinct r5.customer_id from rental r5 where r5.return_date is null;

-- mes y año con mayor pago por customer
SELECT 
    r.customer_id,
    YEAR(r.rental_date) as anio,
    MONTH(r.rental_date) as mes,
    SUM(p.amount) as total_mes
FROM
    payment p
        JOIN
    rental r ON p.rental_id = r.rental_id
GROUP BY r.customer_id,YEAR(r.rental_date) , MONTH(r.rental_date);

-- Maximo por cliente
SELECT 
    customer_id, MAX(total_mes) AS max_pago
FROM
    (SELECT 
        r.customer_id,
            YEAR(r.rental_date) AS anio,
            MONTH(r.rental_date) AS mes,
            SUM(p.amount) AS total_mes
    FROM
        payment p
    JOIN rental r ON p.rental_id = r.rental_id
    GROUP BY r.customer_id , YEAR(r.rental_date) , MONTH(r.rental_date)) aux1_copia
GROUP BY customer_id;

-- union de la primera con la segunda
SELECT 
    aux1.customer_id, aux1.anio AS anio1, aux1.mes AS mes1
FROM
    (SELECT 
        r.customer_id,
            YEAR(r.rental_date) AS anio,
            MONTH(r.rental_date) AS mes,
            SUM(p.amount) AS total_mes
    FROM
        payment p
    JOIN rental r ON p.rental_id = r.rental_id
    GROUP BY r.customer_id , YEAR(r.rental_date) , MONTH(r.rental_date)) aux1
        JOIN
    (SELECT 
        customer_id, MAX(total_mes) AS max_pago
    FROM
        (SELECT 
        r.customer_id,
            YEAR(r.rental_date) AS anio,
            MONTH(r.rental_date) AS mes,
            SUM(p.amount) AS total_mes
    FROM
        payment p
    JOIN rental r ON p.rental_id = r.rental_id
    GROUP BY r.customer_id , YEAR(r.rental_date) , MONTH(r.rental_date)) aux1_copia
    GROUP BY customer_id) maximos ON maximos.customer_id = aux1.customer_id
        AND maximos.max_pago = aux1.total_mes;

-- cantidad de alquileres realizados por un determinado cliente, en un mes y anio
SELECT 
    COUNT(*)
FROM
    rental r4
WHERE
    r4.customer_id = 2
        AND MONTH(r4.rental_date) = 5
        AND YEAR(r4.rental_date) = 2005;

-- ############################################################################################
-- ############################################################################################
-- ############################################################################################
-- EJERCICIO 4.
-- Recupere de la base de datos un listado de todos los actores que han recaudado por sus 
-- películas mas que el promedio de los actores. Para el calculo del promedio tener en 
-- cuenta los actores que no tienen recaudacion.
-- De cada actor en el listado deberá indicar: 
-- NOMBRE y APELLIDO
-- CANTIDAD DE PELÍCULAS QUE ACTUÓ 
-- CANTIDAD DE ALQUILERES NO DEVUELTOS DE ESE ACTOR
-- PROMEDIO DE RECUDACION DE TODOS LOS ACTORES (esta columna tendrá el mismo valor en todas las filas)
-- El estado de los datos de ejemplo es uno de los posibles estados, la consulta debe funcionar correctamente cualquiera sean los datos.

SELECT 
    a.first_name,
    a.last_name,
    (SELECT 
            COUNT(*)
        FROM
            film_actor
        WHERE
            actor_id = a.actor_id) AS cantPeliculasActuados,
    SUM(p.amount) AS montoTotal,
    (SELECT 
            COUNT(*)
        FROM
            rental r2
                JOIN
            inventory i2 ON i2.inventory_id = r2.inventory_id
                JOIN
            film_actor fa2 ON fa2.film_id = i2.film_id
        WHERE
            fa2.actor_id = a.actor_id
                AND r2.return_date IS NULL) AS cantNoDevueltos,
    (SELECT 
            AVG(aux1.totalRecaudado)
        FROM
            (SELECT 
                SUM(p1.amount) AS totalRecaudado
            FROM
                payment p1
            JOIN rental r1 ON p1.rental_id = r1.rental_id
            JOIN inventory i1 ON i1.inventory_id = r1.inventory_id
            JOIN film_actor fa ON fa.film_id = i1.film_id
            GROUP BY fa.actor_id) aux1) promRecaudacionActor
FROM
    actor a
        JOIN
    film_actor fa ON fa.actor_id = a.actor_id
        JOIN
    inventory i ON i.film_id = fa.film_id
        JOIN
    rental r ON r.inventory_id = i.inventory_id
        JOIN
    payment p ON p.rental_id = r.rental_id
GROUP BY a.actor_id
HAVING montoTotal > (SELECT 
        AVG(aux1.totalRecaudado)
    FROM
        (SELECT 
            SUM(p1.amount) AS totalRecaudado
        FROM
            payment p1
        JOIN rental r1 ON p1.rental_id = r1.rental_id
        JOIN inventory i1 ON i1.inventory_id = r1.inventory_id
        JOIN film_actor fa ON fa.film_id = i1.film_id
        GROUP BY fa.actor_id) aux1);

-- cantidad de peliculas en las que actuo un actor
SELECT 
    COUNT(*)
FROM
    film_actor
WHERE
    actor_id = 1;

-- cantidad alquileres no devueltos
SELECT 
    COUNT(*)
FROM
    rental r2
        JOIN
    inventory i2 ON i2.inventory_id = r2.inventory_id
        JOIN
    film_actor fa2 ON fa2.film_id = i2.film_id
WHERE
    fa2.actor_id = 1
        AND r2.return_date IS NULL;

-- Suma de lo que recaudo cada actor
SELECT 
    SUM(p1.amount) AS totalRecaudado
FROM
    payment p1
        JOIN
    rental r1 ON p1.rental_id = r1.rental_id
        JOIN
    inventory i1 ON i1.inventory_id = r1.inventory_id
        JOIN
    film_actor fa ON fa.film_id = i1.film_id
GROUP BY fa.actor_id;

-- Promedio recaudado
SELECT 
    AVG(aux1.totalRecaudado)
FROM
    (SELECT 
        SUM(p1.amount) AS totalRecaudado
    FROM
        payment p1
    JOIN rental r1 ON p1.rental_id = r1.rental_id
    JOIN inventory i1 ON i1.inventory_id = r1.inventory_id
    JOIN film_actor fa ON fa.film_id = i1.film_id
    GROUP BY fa.actor_id) aux1;

-- ############################################################################################
-- ############################################################################################
-- ############################################################################################
-- EJERCICIO 5.
-- Recupere la actuación de los clientes generando un listado de los clientes por la cantidad de alquileres realizados, 
-- cada renglón del listado deberá contener lo siguiente:
-- Apellido del cliente ok 
-- Nombre del cliente ok 
-- Cantidad total de alquileres realizados ok 
-- Mes y año en el que ese cliente realizó más alquileres, si hay mas de uno mayor mostrar uno solo.
-- Cantidad de alquileres que realizó en ese mes y año
-- Solo mostrar los clientes que no tengan alquileres no devueltos. Ordenar por apellido y nombre. ok
-- APELLIDOCLIENTE NOMBRECLIENTE CANTTOTAL MESMAYOR ANOMAYOR CANTIDAD
SELECT 
    c.last_name AS APELLIDOCLIENTE,
    c.first_name AS NOMBRECLIENTE,
    COUNT(DISTINCT r.rental_id) AS CANTTOTAL,
    maximasRentas.mesMAX AS MESMAYOR,
    maximasRentas.anioMAX AS ANOMAYOR,
    maximasRentas.cantRentasMax AS CANTIDAD
FROM
    customer c
        JOIN
    rental r ON r.customer_id = c.customer_id
        JOIN
    (SELECT 
        aux1.cliente AS idCliente,
            aux1.anio AS anioMAX,
            aux1.mes AS mesMAX,
            aux1.cantRentas AS cantRentasMax
    FROM
        (SELECT 
        r2.customer_id AS cliente,
            YEAR(r2.rental_date) AS anio,
            MONTH(r2.rental_date) AS mes,
            COUNT(*) AS cantRentas
    FROM
        rental r2
    GROUP BY r2.customer_id , YEAR(r2.rental_date) , MONTH(r2.rental_date)) aux1
    JOIN (SELECT 
        aux1.customer_id AS cliente,
            MAX(aux1.cantRentas1) AS maxRentas
    FROM
        (SELECT 
        r2.customer_id,
            YEAR(r2.rental_date),
            MONTH(r2.rental_date),
            COUNT(*) AS cantRentas1
    FROM
        rental r2
    GROUP BY r2.customer_id , YEAR(r2.rental_date) , MONTH(r2.rental_date)) AS aux1
    GROUP BY aux1.customer_id) aux2 ON aux1.cliente = aux2.cliente
        AND aux1.cantRentas = aux2.maxRentas) maximasRentas ON maximasRentas.idCliente = c.customer_id
WHERE
    c.customer_id NOT IN (SELECT DISTINCT
            r1.customer_id
        FROM
            rental r1
        WHERE
            r1.return_date IS NULL)
GROUP BY c.customer_id , maximasRentas.mesMAX , maximasRentas.anioMAX , maximasRentas.cantRentasMax
ORDER BY c.last_name , c.first_name;

-- id clientes que tienen rentas pendientes
select distinct r1.customer_id from rental r1 where r1.return_date is null;

-- Obtengo cantidad de rentas por año - mes de un cliente
SELECT 
    r2.customer_id,
    YEAR(r2.rental_date),
    MONTH(r2.rental_date),
    COUNT(*)
FROM
    rental r2
GROUP BY r2.customer_id , YEAR(r2.rental_date) , MONTH(r2.rental_date);

-- Obtengo el maximo de rentas para un año y mes de un cliente
SELECT 
    aux1.customer_id, MAX(aux1.cantRentas1)
FROM
    (SELECT 
        r2.customer_id,
            YEAR(r2.rental_date),
            MONTH(r2.rental_date),
            COUNT(*) AS cantRentas1
    FROM
        rental r2
    GROUP BY r2.customer_id , YEAR(r2.rental_date) , MONTH(r2.rental_date)) AS aux1
GROUP BY aux1.customer_id;

-- obtengo anio, mes para la cantida maxima.
SELECT 
    aux1.cliente AS idCliente,
    aux1.anio AS anioMAX,
    aux1.mes AS mesMAX,
    aux1.cantRentas AS cantRentasMax
FROM
    (SELECT 
        r2.customer_id AS cliente,
            YEAR(r2.rental_date) AS anio,
            MONTH(r2.rental_date) AS mes,
            COUNT(*) AS cantRentas
    FROM
        rental r2
    GROUP BY r2.customer_id , YEAR(r2.rental_date) , MONTH(r2.rental_date)) aux1
        JOIN
    (SELECT 
        aux1.customer_id AS cliente,
            MAX(aux1.cantRentas1) AS maxRentas
    FROM
        (SELECT 
        r2.customer_id,
            YEAR(r2.rental_date),
            MONTH(r2.rental_date),
            COUNT(*) AS cantRentas1
    FROM
        rental r2
    GROUP BY r2.customer_id , YEAR(r2.rental_date) , MONTH(r2.rental_date)) AS aux1
    GROUP BY aux1.customer_id) aux2 ON aux1.cliente = aux2.cliente
        AND aux1.cantRentas = aux2.maxRentas;

-- ############################################################################################
-- ############################################################################################
-- ############################################################################################
-- EJERCICIO 6.
-- Generar una consulta SQL que genere un registro para cada combinacion film y pais, 
-- La consulta calculará la cantidad de alquileres de ese film realizados por clientes que viven en ese pais. 
-- Si no hay alquileres de un film realizados por clientes de un pais poner 0 (cero), no se aceptan null. (10pts)
-- Además, incluir una columna que contenga la cantidad de alquileres no devueltos de ese film por clientes que viven en ese pais.(10pts)
-- Por último agregar una columna que recupere la cantidad de copias que existen de ese film (este valor se repetirá por cada registro de un mismo film).(10pts)
-- Ordenar por CANTIDAD_ALQ descendente.(5pts)
-- El listado debe incluir SOLO los films que tengan en total mas de 20 alquileres combinados con TODOS los paises. (15pts)
-- El reporte tendra las siguientes columnas:
-- TITULO_FILM NOMBRE_PAIS CANTIDAD_ALQ NO_DEVUELTOS COPIAS_FILM

-- ############################################################################################
-- ############################################################################################
-- ############################################################################################

#recupere la actuacion de los clientes generando un listado de los clientes, cada renglon del listado debera contener:

#Apellido del cliente
#Nombre del cliente
#Monto total de pagos realizado
#Mes y año en el que ese cliente pago mas por todos los alquileres del mes, si hay mas de uno mayor mostrar solo 1
#cantidad de alquileres que realizo en ese mes y año

#Solo mostrar los clientes que tengan al menos un alquiler no devuelto
#Ordenar por monto total decendente

-- ############################################################################################
-- ############################################################################################
-- ############################################################################################

-- Implemente una consulta sobre la base de datos “Sakila” que liste  los actores, el monto de alquileres cobrados de sus films y 
-- el nombre de la pelicula que  mas recaudó dentro de las que trabajó ese actor , muéstrelos ordenados por monto de alquileres de mayor a menor.
-- El listado tendrá las siguientes columnas:
-- 1- Nombre del actor
-- 2- Apellido del actor
-- 3- Monto cobrado por alquileres de sus films
-- 4- Nombre de la película mas taquillera entre las que actúa
-- El estado actual de los datos es uno de los posibles estados, la consulta debe funcionar correctamente cualquiera sea el estado de los datos,puede que sea necesario modificar los datos para probar diferentes posibilidades.

-- ############################################################################################
-- ############################################################################################
-- ############################################################################################

#Implemente una consulta sobre la base de datos “Sakila” que liste  los actores, 
#el monto de alquileres cobrados de sus films y el nombre de la pelicula que 
#mas recaudó dentro de las que trabajó ese actor , muéstrelos ordenados por monto de alquileres de mayor a menor.
#El listado tendrá las siguientes columnas:
#1- Nombre del actor
#2- Apellido del actor
#3- Monto cobrado por alquileres de sus films
#4- Nombre de la película mas taquillera entre las que actúa

-- Apparently everything OK (i compared it with the file that Bada sent me: 'examenFinal'.
-- Bada's file isn't ordered by total earnings,careful)

-- ############################################################################################
-- ############################################################################################
-- ############################################################################################

#Genere una consulta SQL sobre la base Sakila que retorne una tabla 
#de 4 columnas que tenga 1 registro por cada "actor" con los campos:
#. Apellido del Actor
#. Cantidad de films que superaron la recaudación promedio 
#de todos los films de la base de datos - Usar el campo amount de la tabla payment.
#. Cantidad de categorías distintas de los films del actor.
#. Cantidad total de alquileres de films en los que participó.
#El estado de los datos es uno de los posibles de la Base de Datos,
# la consulta debe funcionar cuelquiera sea el estado.

#. Cantidad de films que superaron la recaudación promedio 
#de todos los films de la base de datos - Usar el campo amount de la tabla payment.