xquery version "3.1";

<result>{
for $b in doc("books.xml")//book
stable order by number($b/price) ascending
return $b}</result>