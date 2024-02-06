type author = string

type t = {
  isbn: string,
  title: string,
  authors: array<author>,
  publishedAt: option<Js.Date.t>,
  imageUrl: string,
}

module Decode = {
  open! Json.Decode

  let t = object(field => {
    isbn: field.required("isbn", string),
    title: field.required("title", string),
    authors: field.required("authors", array(string)),
    publishedAt: field.required("published_at", option(string))->Belt.Option.map(
      Js.Date.fromString,
    ),
    imageUrl: field.required("image", option(string))->Belt.Option.getWithDefault(""),
  })
}
