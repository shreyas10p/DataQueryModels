USE employees;
select e.emp_no,e.birth_date,e.gender 
FROM employees as e
order by e.birth_date,e.emp_no;