USE sakila;
INSERT INTO actor(first_name,last_name)
values ('KENNETH','OLIVIER');
SELECT first_name,last_name FROM sakila.actor
where first_name = 'KENNETH';