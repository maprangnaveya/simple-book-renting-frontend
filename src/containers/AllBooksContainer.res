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
    ApiRequest.Loading(None)->RequestBooks->dispatch
    Apis.getBooksWithPagination(~page=state.page, ~token?, ())
    ->Promise.then(result => {
      switch result {
      | Ok(booksWithPagination) =>
        Belt.Array.concat(state.allBooks, booksWithPagination.results)->SetAllBooks->dispatch
        ApiRequest.LoadSuccess(booksWithPagination)
      | Error(errorMsg) => ApiRequest.LoadFailed(errorMsg)
      }
      ->RequestBooks
      ->dispatch
      ->Promise.resolve
    })
    ->ignore
    None
  }, [token])

  <BookShelf
    title="Books"
    books=state.allBooks
    isLoading={Js.Array2.length(state.allBooks) == 0 && state.booksApiRequest->ApiRequest.isLoading}
  />
}
