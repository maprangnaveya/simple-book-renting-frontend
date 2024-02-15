type bookRequest = ApiRequest.t<Book.t, string>

let mockupLongParagraph = "Drink the Kool-aid cadence. My grasp on reality right now is tenuous screw the pooch, but gain alignment five-year strategic plan closer to the metal. Quick sync baseline the procedure and samepage your department hit the ground running, or optimize the fireball. A loss a day will keep you focus we need to follow protocol, so bench mark, for we want to see more charts, for we need to dialog around your choice of work attire. Gain traction shoot me an email push back, yet start procrastinating 2 hours get to do work while procrastinating open book pretend to read while manager stands and watches silently nobody is looking quick do your web search manager caught you and you are fured, and we need distributors to evangelize the new line to local markets. I called the it department about that ransomware because of the old antivirus, but he said that we were using avast 2021. Can we parallel path crank this out, waste of resources, and draw a line in the sand increase the pipelines, green technology and climate change ."

let getBookById = (~id, books: array<Book.t>) => {
  books->Belt.Array.getBy(book => book.id == id)
}

let detailElement = (~label, ~value) => {
  <p> {`${label}: ${value}`->React.string} </p>
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

  <div className="book-detail-page">
    <Breadcrumbs breadcrumbs=[{href: Links.home, label: "Home"}] current="Book Detail" />
    {switch bookRequest {
    | NotAsked => React.null
    | Loading(None) => <Loading />
    | LoadFailed(errorMessage) => errorMessage->React.string
    | Loading(Some(book: Book.t)) | LoadSuccess(book) =>
      <>
        <p className="text-3xl pb-4"> {book.title->React.string} </p>
        <Mui.Grid container=true spacing={Mui.Grid.Int(2)} alignItems=Mui.System.Value.Center>
          <Mui.Grid
            key={`book-list-element-${Belt.Int.toString(book.id)}-${book.isbn}`}
            item=true
            lg={Mui.Grid.Number(6)}>
            <Image image=book.imageUrl alt={`book-cover-${book.isbn}`} />
          </Mui.Grid>
          <Mui.Grid
            key={`book-content-element-${Belt.Int.toString(book.id)}-${book.isbn}`}
            item=true
            lg={Mui.Grid.Number(6)}>
            <Mui.Stack>
              {detailElement(~label="ISBN", ~value=book.isbn)}
              {detailElement(~label="Authors", ~value=Js.Array2.joinWith(book.authors, ", "))}
              <p> {`${Belt.Int.toString(book.availableInStore)} in stock`->React.string} </p>
              <br />
              <p> {mockupLongParagraph->React.string} </p>
            </Mui.Stack>
          </Mui.Grid>
        </Mui.Grid>
      </>
    }}
  </div>
}
