USE employees;
select t2.dept_name,t1.count-1 as cnt
from(select dm.dept_no,count(*) as count
from dept_manager as dm
group by dm.dept_no
) t1 join departments t2 on t1.dept_no = t2.dept_no
where t1.count > 2
order by t2.dept_name;