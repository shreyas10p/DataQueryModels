USE employees;
WITH subquery as (select s.emp_no,s.salary from salaries s
where s.emp_no<20000 and s.to_date = '9999-01-01'
) 
select t2.emp_no,((t2.cnt)/(t3.total_cnt))*100 as percentile from (
select t1.emp_no,count(*)-1 as cnt from subquery t1 join subquery t2 on t1.salary>=t2.salary
group by t1.emp_no
) t2, (select count(*)-1 as total_cnt from salaries s where s.emp_no<20000 and s.to_date = '9999-01-01') t3
order by t2.emp_no