type t<'content, 'error> =
  | NotAsked
  | Loading(option<'content>)
  | LoadSuccess('content)
  | LoadFailed('error)

let isLoading = (t): bool => {
  switch t {
  | Loading(_) => true
  | _ => false
  }
}
