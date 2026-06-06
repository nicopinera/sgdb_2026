-- Pregunta 1
-- Qué rating de películas (film) tienen un costo de reemplazo (replacement_cost) promedio superior a $20,
SELECT rating,
    AVG(replacement_cost) COSTO_REEMPLAZO_PROMEDIO,
    SUM(replacement_cost)
FROM film
GROUP BY rating
HAVING AVG(replacement_cost) > 20;
-- Pregunta 2
-- Todas las películas de la tabla 'film' cuya duración (length) sea mayor a 100 minutos y su clasificación (rating) sea 'G'
SELECT *
FROM film
WHERE length > 100
    AND rating = 'G';
-- Pregunta 3
-- Obtener los 'customer_id' que han gastado más de $150 en total en la tabla 'payment'.
SELECT customer_id,
    SUM(amount)
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 150
ORDER BY SUM(amount) DESC;
-- Pregunta 4
-- En la tabla 'film', cuántas películas hay de cada clasificación (rating), pero solo te interesan aquellas clasificaciones con más de 200 películas
SELECT rating,
    COUNT(*)
FROM film
GROUP BY rating
HAVING COUNT(*) > 200;
-- Pregunta 5
-- Devuelva el ID del inventario (inventory_id) de la tabla 'rental' para los alquileres realizados en mayo de 2005
SELECT inventory_id,
    rental_date
FROM rental
WHERE MONTH(rental_date) = 5
    AND YEAR(rental_date) = 2005;
-- Pregunta 6
-- Identifica a los IDs de clientes (customer_id) en la tabla rental que han realizado más de 35 alquileres en total
SELECT customer_id,
    COUNT(*)
FROM rental
GROUP BY customer_id
HAVING COUNT(*) > 35;