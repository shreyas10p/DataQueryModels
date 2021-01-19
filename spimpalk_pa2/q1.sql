USE employees;
WITH empquery as (
select e.emp_no from employees e join dept_emp d on e.emp_no = d.emp_no  
where d.dept_no = 'd002' and year(e.birth_date) = 1956 and d.to_date='9999-01-01' and e.emp_no < 100000
), salquery as (
select e1.emp_no,s.salary from empquery e1 join salaries s on e1.emp_no = s.emp_no 
where s.to_date = '9999-01-01'
)
select s1.emp_no as e1, s2.emp_no as e2 from salquery s1, salquery s2 
where s2.salary > s1.salary and s1.emp_no > s2.emp_no 
order by s1.emp_no,s2.emp_no
 