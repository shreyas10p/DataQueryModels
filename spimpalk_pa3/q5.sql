use sakila;
WITH RECURSIVE Anc(cust1,cust2,total,cnt) as (
select a2.customer_id as c1,a1.customer_id as c2,
round(ST_Distance_Sphere(a1.location, a2.location) * .000621371192,2)  as dist ,0
from (select b1.customer_id,t2.location from address  as t2 
join customer as b1 on b1.address_id = t2.address_id) as a1,
(select b1.customer_id,t2.location from address  as t2 
join customer as b1 on b1.address_id = t2.address_id) as a2
where a1.customer_id < a2.customer_id 
and (ST_X(a1.location) between -180 and 180) and (ST_X(a2.location) between -180 and 180)
and ST_Y(a1.location) <90 and ST_Y(a2.location) <90 
and (round(ST_Distance_Sphere(a1.location, a2.location) * .000621371192,2)) < 20 
and (round(ST_Distance_Sphere(a1.location, a2.location) * .000621371192,2)) <> 0  
UNION
select a.cust1,parent.c2,(a.total)+(parent.dist),a.cust2 from Anc a,
(select a2.customer_id as c1,a1.customer_id as c2,
round(ST_Distance_Sphere(a1.location, a2.location) * .000621371192,2)  as dist 
from (select b1.customer_id,t2.location from address  as t2 
join customer as b1 on b1.address_id = t2.address_id) as a1,
(select b1.customer_id,t2.location from address  as t2 
join customer as b1 on b1.address_id = t2.address_id) as a2
where a1.customer_id < a2.customer_id 
and (ST_X(a1.location) between -180 and 180) and (ST_X(a2.location) between -180 and 180)
and ST_Y(a1.location) <90 and ST_Y(a2.location) <90 
and (round(ST_Distance_Sphere(a1.location, a2.location) * .000621371192,2)) < 20 
and (ST_Distance_Sphere(a1.location, a2.location) * .000621371192) <> 0) as parent
where a.cust2 = parent.c1 and a.cust1<>parent.c2
)

select t1.c1,t1.c2,t1.distance as distance from (select cust2 as c1,cust1 as c2,min(total) as distance,cnt from Anc
group by cust1,cust2
order by cust2,cust1
) as t1
left join
(
select cnt as c1,cust1 as c2,min(total) as distance from Anc
where cnt <>0
group by cnt,cust1
order by cnt,cust1
) as t2 on t1.c1 = t2.c1 and t1.c2 = t2.c2
where t2.c1 is NULL

