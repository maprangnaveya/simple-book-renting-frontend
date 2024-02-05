type requestMethod =
  | @as("GET") GET
  | @as("PATCH") PATCH
  | @as("POST") POST

let networkErrorMessage = "Unexpected network error occurred"

module Response = {
  type t<'data>

  @send external json: t<'data> => promise<'data> = "json"
}
@val @scope("globalThis")
external fetch: (string, 'params) => promise<Response.t<'json>> = "fetch"

module Decode = {
  open! Json.Decode

  let error = field("non_field_errors", array(string))

  let getResponseMsgFromJson = json => {
    let jsonString = Json.stringify(json)
    let re = Js.Re.fromStringWithFlags("[\\[\\]\\{\\}\"]", ~flags="g")
    let splitMsg = Js.String.split(":", Js.String.replaceByRe(re, "", jsonString))
    splitMsg[Js.Array.length(splitMsg) - 1]
  }
}

let request = async (~url, ~method: requestMethod, ~body=?, ~decode) => {
  let params = {
    "method": method,
    "headers": {
      "Content-Type": "application/json",
    },
    "body": body->Belt.Option.map(Js.Json.stringifyAny),
  }

  try {
    let response = await fetch(url, params)
    let data = await response->Response.json

    switch Json.Decode.decode(data, decode) {
    | Ok(t) => Ok(t)
    | Error(msg) => {
        Js.log2("DecodeError", msg)
        switch Json.Decode.decode(data, Decode.error) {
        | Ok(errorMessages) => Error(errorMessages->Js.Array2.joinWith(", "))
        | Error(_) =>
          Error(
            Decode.getResponseMsgFromJson(data)->Belt.Option.getWithDefault(networkErrorMessage),
          )
        }
      }
    }
  } catch {
  | _ => Error(networkErrorMessage)
  }
}
