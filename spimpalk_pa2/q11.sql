use sakila;
with subquery as (
select r.rental_id,r.rental_date,r.customer_id,i.film_id from rental r 
join inventory i on r.inventory_id = i.inventory_id
)
select f1.film_id as f1,f2.film_id as f2,count(distinct f1.customer_id) as cnt
from subquery f1 join subquery f2 on f1.customer_id = f2.customer_id and f1.film_id<>f2.film_id 
and f2.rental_date > f1.rental_date 
where not exists(
select * from subquery f3 
where f1.customer_id = f3.customer_id
and f2.rental_date > f3.rental_date and f1.rental_date<f3.rental_date 
and f1.film_id<>f3.film_id and f2.film_id<>f3.film_id
) 
group by f1.film_id,f2.film_id
order by cnt desc,f1.film_id asc,f2.film_id asc

 
