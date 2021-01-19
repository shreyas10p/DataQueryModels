# Needs review
use sakila;
SELECT a.title as flim1,b.title as film2,a.length,a.rating 
FROM film as a join film as b on 
a.length = b.length and a.rating = b.rating and a.title<>b.title
ORDER BY a.title,b.title;