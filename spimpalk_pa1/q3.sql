USE employees;
select e.last_name,s.salary,s.from_date,s.to_date
from employees as e join salaries as s on e.emp_no = s.emp_no
order by e.last_name,s.from_date;