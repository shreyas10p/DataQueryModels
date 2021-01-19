xquery version "3.1";

<biblio>{
let $books := doc("/db/books.xml")
let $booktitles := distinct-values($books/biblio//title)
for $title in $booktitles
let $authorbooks := $books/biblio/author/book[title=$title]
return  <book year='{distinct-values($authorbooks/@year/string())}'>
{  
for $author in $books/biblio/author/book[title=$title]/../name
return <author><name> 
{$author/string()} 
</name> 
</author>
}
<title> {$title} </title> 
<price> {distinct-values($authorbooks/price)} </price> 
</book>
}
</biblio>