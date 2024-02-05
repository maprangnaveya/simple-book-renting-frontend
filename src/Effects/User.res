type t = {
  email: string,
  firstName: string,
  lastName: string,
  birthdate: option<Js.Date.t>,
  isStaff: bool,
}

module Decode = {
  open! Json.Decode
  let t = object(field => {
    email: field.required("email", string),
    firstName: field.required("first_name", string),
    lastName: field.required("last_name", string),
    birthdate: field.required("birth_date", option(string))->Belt.Option.map(Js.Date.fromString),
    isStaff: field.required("is_staff", bool),
  })
}
