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

let request = async (~url, ~method: requestMethod, ~body=?, ~token=?, ~decode) => {
  let headersDict = Js.Dict.empty()
  headersDict->Js.Dict.set("Content-Type", "application/json")
  switch token {
  | None => ()
  | Some(tokenKey) => headersDict->Js.Dict.set("Authorization", `Token ${tokenKey}`)
  }

  let params = {
    "method": method,
    "headers": headersDict,
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
