USE sakila;
select CONCAT_WS(" ",a.first_name,a.last_name) as actor_name,count(distinct fac.category_id) as ncat from(
select fa.actor_id,fc.category_id from film_actor fa left join film_category fc
on fa.film_id = fc.film_id
) fac join actor a on fac.actor_id = a.actor_id
group by actor_name
order by actor_name