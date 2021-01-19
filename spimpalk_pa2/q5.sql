
USE employees;
select t3.emp_no,t3.from_date as on_date,t3.o_title,t3.n_title,s2.salary as o_salary,t3.n_salary as n_salary from(
select t2.emp_no,t2.from_date,t2.o_title,t2.n_title,s1.salary as n_salary from (
select t1.emp_no, t1.title as n_title, t2.title as o_title,t1.from_date from 
titles t1 join titles t2 on (t1.emp_no=t2.emp_no and t1.title <> t2.title and t1.from_date = t2.to_date)
) t2 join salaries s1 on s1.emp_no = t2.emp_no and (t2.from_date = s1.from_date)) t3 join salaries s2 
on s2.emp_no = t3.emp_no and t3.from_date = s2.to_date 
where s2.salary>t3.n_salary

