USE sakila;
SELECT f.film_id,f.title FROM film as f
where f.rental_rate<1;