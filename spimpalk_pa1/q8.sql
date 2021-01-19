USE sakila;
UPDATE customer
SET active = 0
WHERE email = "MARIA.MILLER@sakilacustomer.org";

select email,active from customer
where email = "MARIA.MILLER@sakilacustomer.org";
