let baseUrl = `${Env.api_url}/api/v1`

let booksPath = `${baseUrl}/books/`
let bookDetailPath = id => `${baseUrl}/books/${id}/`
let bookAvailablePath = `${baseUrl}/books/available/`

type url = string
type pagination<'data> = {
  count: int,
  @as("next") next_: option<url>,
  previous: option<url>,
  results: array<'data>,
}

module Decode = {
  open! Json.Decode
  let url = option(string)

  let pagination = (~resultDecode) =>
    object(field => {
      count: field.required("count", int),
      next_: field.required("next", url),
      previous: field.required("previous", url),
      results: field.required("results", array(resultDecode)),
    })
}

let getBooksWithPagination = (~page=1, ~token=?, ()) => {
  RequestUtils.request(
    ~url=booksPath ++ `?page=${Belt.Int.toString(page)}`,
    ~method=RequestUtils.GET,
    ~token?,
    ~decode=Decode.pagination(~resultDecode=Book.Decode.t),
  )
}

let getBook = (~token, ~id) => {
  RequestUtils.request(
    ~url=bookDetailPath(Belt.Int.toString(id)),
    ~method=RequestUtils.GET,
    ~token,
    ~decode=Book.Decode.t,
  )
}
