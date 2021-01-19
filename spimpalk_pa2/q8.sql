USE sakila;
select p1.rental_id,p1.payment_id 
from payment p1 where p1.amount < 
ALL(select p2.amount from payment p2 
where p2.amount<>p1.amount)
order by p1.rental_id