USE sakila;

/*Query 1*/
SELECT film.title AS 'Movie Title', inventory.store_id AS 'Store', COUNT(film.film_id) AS 'Copies'
FROM film
LEFT JOIN inventory
	ON film.film_id = inventory.film_id
WHERE film.title = 'Hunchback Impossible'
GROUP BY film.title, inventory.store_id;


/*Query 2*/
SELECT film.title AS 'Long Movie', film.length AS 'Duration'
FROM film
WHERE film.length > (SELECT AVG(film.length) FROM film)
ORDER BY length DESC, film.title;


/*Query 3*/
SELECT actor.first_name AS 'First Name', actor.last_name AS 'Last Name'
FROM actor
JOIN film_actor 
	ON film_actor.actor_id = actor.actor_id
WHERE film_actor.film_id = (
	SELECT film.film_id
	FROM film
	WHERE film.title = 'Alone Trip');


/*Query 4*/
SELECT title AS 'Family Movie', description AS 'Movie Description', rating AS 'MPAA Rating'
FROM film
WHERE rating = 'G' OR rating = 'PG';


/*Query 5*/
SELECT address.city_id, country.country, customer.first_name, customer.last_name, customer.email
FROM address
LEFT JOIN city
	ON address.city_id = city.city_id
LEFT JOIN country
	ON city.country_id = country.country_id
LEFT JOIN customer
	ON address.address_id = customer.address_id
WHERE country = 'Canada'
ORDER BY customer.first_name ASC;


/*Query 6: find the most prolific Actor*/
SELECT actor.actor_id, actor.first_name AS 'First Name', actor.last_name AS 'Last Name', COUNT(actor.actor_id) AS 'Total Movie'
FROM actor
LEFT JOIN film_actor
	ON actor.actor_id = film_actor.actor_id
LEFT JOIN film
	ON film_actor.film_id = film.film_id
GROUP BY actor.actor_id, actor.first_name, actor.last_name
ORDER BY COUNT(actor.actor_id) DESC
LIMIT 1;

/*Query 6: List of the Movies with the most prolofic Actor in them*/
SELECT  film.title AS 'Movie starring Gina Degeneres'
FROM film
WHERE film.film_id IN (SELECT film_id FROM film_actor WHERE actor_id = 107);


/*Query 7: find the most profitable Customer*/
SELECT customer_id, SUM(amount) AS 'Total spend'
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC;


/*Query 7: find the films rented by the most profitable Customer*/
SELECT DISTINCT inventory.film_id
FROM payment
LEFT JOIN rental
	ON payment.customer_id = rental.customer_id
LEFT JOIN inventory
	ON rental.inventory_id = inventory.inventory_id
WHERE payment.customer_id = (SELECT customer_id
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 1)
ORDER BY film_id;


/*Query 8*/
