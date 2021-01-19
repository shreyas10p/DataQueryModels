USE employees;
select e.emp_no as emp, m.emp_no as mgr, e.from_date
from dept_emp as e join 
(select d.emp_no,d.dept_no,d.from_date,d.to_date from dept_manager as d join ( 
select dept_no,max(from_date) as from_date 
from dept_manager 
group by dept_no) as j on d.dept_no = j.dept_no and d.from_date = j.from_date) as m on e.dept_no = m.dept_no
order by e.emp_no;