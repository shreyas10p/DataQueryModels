select * from (
select a.dept_name,count(d.emp_no) as noe from dept_emp as d join departments as a on d.dept_no = a.dept_no
where d.to_date = '9999-01-01'
group by d.dept_no 
order by a.dept_name) as current_emp
where current_emp.noe > 20000