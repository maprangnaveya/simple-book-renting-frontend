type bookRequest = ApiRequest.t<Book.t, string>

let getBookById = (~id, books: array<Book.t>) => {
  books->Belt.Array.getBy(book => book.id == id)
}

@react.component
let make = (~id: int) => {
  let {token} = TokenContext.getContext()
  //   let {books} = BookContext.getContext() TODO: Get from BookContext if does exists
  let (bookRequest, setBookRequest) = React.useState(_ => ApiRequest.NotAsked)

  React.useEffect(_ => {
    switch token {
    | None => ()
    | Some(token) =>
      setBookRequest(_ => ApiRequest.Loading(None))
      Apis.getBook(~token, ~id)
      ->Promise.then(result => {
        switch result {
        | Ok(book) => setBookRequest(_ => ApiRequest.LoadSuccess(book))
        | Error(errorMsg) => setBookRequest(_ => ApiRequest.LoadFailed(errorMsg))
        }->Promise.resolve
      })
      ->ignore
    }

    None
  }, [id])

  <div>
    <Breadcrumbs breadcrumbs=[{href: Links.home, label: "Home"}] current="Book Detail" />
    {switch bookRequest {
    | NotAsked => React.null
    | Loading(None) => <Loading />
    | LoadFailed(errorMessage) => errorMessage->React.string
    | Loading(Some(book: Book.t)) | LoadSuccess(book) =>
      <p className="text-3xl pb-4"> {book.title->React.string} </p>
    }}
  </div>
}
