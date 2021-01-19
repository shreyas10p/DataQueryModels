use pa3;
WITH RECURSIVE Anc(sourc,dest) as(
select src,dst from amap
UNION
(select t1.src,t2.dest
from amap t1,Anc t2
where t1.dst = t2.sourc)
)
select sourc as src,dest as dst from Anc
order by sourc,dest;
