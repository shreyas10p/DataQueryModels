WITH RECURSIVE Anc(d,q) AS (
select 1,999
UNION ALL
(select a.d+1.0,999.0/(a.d+1.0)
from Anc a
where a.d+1<=999)
)
select 999 as n,Anc.d,CAST(Anc.q AS DECIMAL(10,4)) as q from Anc
where 999.0%Anc.d = 0 