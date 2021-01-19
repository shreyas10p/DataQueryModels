USE sakila;
select r.customer_id,sum(p.amount) as total,count(r.rental_id) as n_rent
from rental r join payment p on r.customer_id = p.customer_id and r.rental_id = p.rental_id
group by r.customer_id
having total>100
order by r.customer_id

