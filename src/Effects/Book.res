type author = string

type t = {
  isbn: string,
  title: string,
  authors: array<author>,
  publishedAt: option<Js.Date.t>,
}

module Decode = {
  open! Json.Decode

  let t = object(field => {
    isbn: field.required("isbn", string),
    title: field.required("title", string),
    authors: field.required("authors", array(string)),
    publishedAt: field.required("publishedAt", option(string))->Belt.Option.map(Js.Date.fromString),
  })
}
