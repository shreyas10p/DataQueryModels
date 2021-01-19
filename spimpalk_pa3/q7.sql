use pa3;
WITH RECURSIVE Anc(sourc,dest,total,cnt) as (
select src,dst,cost,0 from amap
UNION ALL
(
select t1.src,t2.dest,t1.cost+t2.total,t2.cnt+1
from amap t1,Anc t2
where t1.dst = t2.sourc and t2.cnt<1 and t1.src<>t2.dest
))
select sourc as src,dest as dst,min(total) as cost from Anc
group by sourc,dest
order by sourc,dest