open Mui

@react.component
let make = (~title: string, ~books: array<Book.t>, ~isLoading: bool=false) => {
  <div>
    //   TODO: Pagination
    <p className="text-3xl"> {title->React.string} </p>
    {isLoading ? <Loading /> : React.null}
    <Grid
      container=true
      spacing={Grid.Int(12)}
      justifyContent=System.Value.String("space-around")
      alignItems=System.Value.Center>
      {books
      ->Belt.Array.mapWithIndex((idx, book: Book.t) => {
        <Grid
          key={`book-list-element-${Belt.Int.toString(idx)}-${book.isbn}`} item=true lg={Grid.Auto}>
          <BookCard book />
        </Grid>
      })
      ->React.array}
    </Grid>
  </div>
}
