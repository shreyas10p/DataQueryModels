xquery version "3.1";

<result>{
let $books := doc("/db/books.xml")
let $uniqprices := for $distictprice in distinct-values($books/biblio/author/book/price) 
return xs:integer($distictprice)
let $globalavg := avg($uniqprices)
return (<global_average>{$globalavg}</global_average>,
for $category in $books/biblio/author/book/category group by $category
return <category id='{$category}'>{
    let $catprice := for $book in $books/biblio/author/book where($book/category = $category) return xs:integer($book/price)
    let $catavg := avg($catprice)
    let $catbooks := for $catbook in $books/biblio/author/book where($catbook/category = $category and $catavg>$globalavg) return xs:integer($catbook/price)
    let $highestbooks := for $newbook in $books/biblio/author/book where($newbook/category = $category and $catavg>$globalavg and $newbook/price=max($catbooks)) group by $newbook return <book year='{$newbook/@year/string()}'>{$newbook/title,$newbook/price}</book>
    return (<category_average>{$catavg}</category_average>,$highestbooks)
        
}</category>)
}</result>