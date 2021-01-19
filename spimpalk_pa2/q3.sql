
select d1.emp_no,d2.dept_name
from dept_manager d1 join departments d2 on d1.dept_no = d2.dept_no
where not exists(
select *
from dept_manager d2
where d2.dept_no = d1.dept_no and d2.emp_no <> d1.emp_no 
and datediff(d1.to_date,d1.from_date)>datediff(d2.to_date,d2.from_date))
order by d1.emp_no

