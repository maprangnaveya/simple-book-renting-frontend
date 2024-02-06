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

  <div>
    <Sidebar />
    <div>
      <h1> {`Hello, UserA`->React.string} </h1>
      <BookShelf />
    </div>
  </div>
}
