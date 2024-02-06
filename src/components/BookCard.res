open Mui

@react.component
let make = (~book: Book.t) => {
  <Card className="book-card">
    <CardContent>
      <Image image=book.imageUrl alt={`book-card-${book.isbn}`} />
    </CardContent>
  </Card>
}
