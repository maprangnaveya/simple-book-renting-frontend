@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()
  let {clearToken} = TokenContext.getContext()

  {
    switch url.path {
    | list{"settings"} => "Settings"->React.string
    | list{"books", bookId} =>
      switch Belt.Int.fromString(bookId) {
      | None => "Book id not found."->React.string
      | Some(id) => <BookDetailPage id />
      }
    | list{"logout"} =>
      let _ = clearToken()
      <Loading />
    | _ => <HomePage />
    }
  }
}
