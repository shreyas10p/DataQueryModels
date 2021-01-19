WITH RECURSIVE Anc (n, num, next_num) AS
(
  SELECT 0, 0, 0
  UNION ALL
  (SELECT a.n + 1, a.next_num, CASE 
  WHEN (a.n+1) <= 1 THEN a.n+1
  WHEN ((next_num)%2 = 1) THEN (a.num + a.next_num)
  WHEN ((next_num)%2 = 0) THEN (a.num + a.next_num + 1)
	END
    FROM Anc a 
    WHERE CASE 
  WHEN (a.n+1) <= 1 THEN a.n+1
  WHEN ((next_num)%2 = 1) THEN (a.num + a.next_num)
  WHEN ((next_num)%2 = 0) THEN (a.num + a.next_num + 1) END < 100)
)
SELECT a.n,a.next_num as `f(n)` FROM Anc a
