type booksWithPagination = Apis.pagination<Book.t>

type booksApiRequest = ApiRequest.t<booksWithPagination, string>
type page = int

type action = RequestBooks(booksApiRequest) | SetPage(page) | SetAllBooks(array<Book.t>)

type state = {
  allBooks: array<Book.t>,
  booksApiRequest: booksApiRequest,
  page: page,
}

let reducer = (state, action) => {
  switch action {
  | RequestBooks(booksApiRequest) => {...state, booksApiRequest}
  | SetPage(page) => {...state, page}
  | SetAllBooks(allBooks) => {...state, allBooks}
  }
}

@react.component
let make = () => {
  let {token} = TokenContext.getContext()
  let (state, dispatch) = React.useReducer(
    reducer,
    {booksApiRequest: ApiRequest.NotAsked, page: 1, allBooks: []},
  )

  React.useEffect(_ => {
    Js.log("HOME PAGE useEffect1")
    switch token {
    | None => ()
    | Some(tokenKey) =>
      ApiRequest.Loading(None)->RequestBooks->dispatch
      Apis.getBooksWithPagination(~page=state.page, ~token=tokenKey)
      ->Promise.then(result => {
        switch result {
        | Ok(booksWithPagination) =>
          // TODO: Append
          booksWithPagination.results->SetAllBooks->dispatch
          ApiRequest.LoadSuccess(booksWithPagination)
        | Error(errorMsg) => ApiRequest.LoadFailed(errorMsg)
        }
        ->RequestBooks
        ->dispatch
        ->Promise.resolve
      })
      ->ignore
    }
    None
  }, [token])
  <div>
    <ul>
      {state.allBooks
      ->Belt.Array.mapWithIndex((idx, book: Book.t) => {
        <li key={`book-list-element-${Belt.Int.toString(idx)}-${book.isbn}`}>
          {`isbn: ${book.isbn}, title: ${book.title}, author: ${book.authors->Js.Array2.joinWith(
              ", ",
            )}`->React.string}
        </li>
      })
      ->React.array}
    </ul>
  </div>
}
