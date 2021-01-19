select * from (
select d.film_id,f.replacement_cost-d.rental_sum as to_breakeven from(
select i1.film_id ,sum(p1.amount) as rental_sum
from rental r1 join inventory i1
on r1.inventory_id= i1.inventory_id join payment p1 on r1.rental_id = p1.rental_id
group by i1.film_id) d join film f on f.film_id = d.film_id
where d.rental_sum<f.replacement_cost 
order by to_breakeven
LIMIT 5,5) a
order by a.film_id

