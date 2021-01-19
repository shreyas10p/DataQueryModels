WITH RECURSIVE mul(m,n,prod) AS 
(
select 1,1,1
UNION ALL
(select a.m,a.n+1,(a.m)*(a.n+1)
from mul a
where a.n<9)
),
mul2(num1,num2,prod) AS(
select * from mul
UNION ALL
(select c.n,b.num1,(c.n)*(b.num1)
from mul2 b,mul c
where c.m<>c.n and b.num2 = c.m)
)
select mul2.num1 as m,mul2.num2 as n,mul2.prod as `m*n` from mul2
order by mul2.num1,mul2.num2