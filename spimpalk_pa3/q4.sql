USE employees;
WITH RECURSIVE Anc(num1,num2,num3,mycount) as (
select src,dst,years,0 from (SELECT t2.title as src,t1.title as dst,avg((year(t1.from_date)-year(t2.from_date))+1) as years FROM titles t1,titles t2
where t1.emp_no = t2.emp_no and t1.from_date = t2.to_date and t2.title<>t1.title
group by t2.title,t1.title
order by t2.title) as parent
UNION
select a.num1,parent.dst,a.num3+parent.years,a.mycount+1
from Anc a, 
(SELECT t2.title as src,t1.title as dst,avg((year(t1.from_date)-year(t2.from_date))+1) as years FROM titles t1,titles t2
where t1.emp_no = t2.emp_no and t1.from_date = t2.to_date and t2.title<>t1.title
group by t2.title,t1.title
order by t2.title) as parent
where parent.src = a.num2 and a.num1<>parent.dst and a.mycount<3
)
select num1 as src,num2 as dst, min(num3) as years
from Anc
group by num1,num2
order by num1,num2
