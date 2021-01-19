xquery version "3.1";

<result>{
let $book := doc("/db/books.xml")
for $booktitles in $book/biblio/author[name = 'Jeff']/book/title
for $other_authors in $book/biblio/author[name != 'Jeff']
let $pairs := string-join(($other_authors/book[title = $booktitles]/../name/string(),$booktitles),":")

for $pair in $pairs
let $result := $pair where count(tokenize($pair,":")) eq 2
for $res in $result
return <book>
    <title>{substring-after($res,":")}</title>
    <name>Jeff</name>
    <name>{substring-before($res,":")}</name>
</book>
}</result>
