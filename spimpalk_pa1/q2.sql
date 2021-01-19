USE employees;
SELECT * FROM employees as e
where e.gender = 'M'
order by e.emp_no;