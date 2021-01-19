USE employees;
select d1.dept_name,s1.title,count(*) as cnt from(
select e1.dept_no,t1.title,t1.emp_no
from titles t1 join current_dept_emp e1 on t1.emp_no = e1.emp_no
where t1.to_date = '9999-01-01') s1 join departments d1 on s1.dept_no = d1.dept_no
group by d1.dept_name,s1.title
order by d1.dept_name,s1.title 
