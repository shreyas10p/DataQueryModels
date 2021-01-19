USE sakila;
select i.film_id,f.length,avg(datediff(r.return_date,r.rental_date)) as avg_days
from inventory i join rental r on i.inventory_id = r.inventory_id join film f on i.film_id = f.film_id
group by i.film_id
order by i.film_id