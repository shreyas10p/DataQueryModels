xquery version "3.1";

(<result>
    <pair>{
let $book := doc("/db/books.xml")
for $authorname in $book/biblio/author
for $booktitles in $book/biblio/author[name = $authorname/name]/book/title
for $other_authors in $book/biblio/author[name != $authorname/name]
let $pairs := string-join(($other_authors/book[title = $booktitles]/../name/string(),$booktitles),":")
for $pair in $pairs
let $result := $pair where count(tokenize($pair,":")) eq 2
for $res in $result
return (<name>{$authorname/name/string()}</name>, 
        <name>{substring-before($res,":")}</name>,
    for $b in $book/biblio/author/book[title = substring-after($res,":")] return $b)
}</pair>
    
</result>)