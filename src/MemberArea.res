@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()
  let {clearToken} = TokenContext.getContext()

  {
    switch url.path {
    | list{"settings"} => "Settings"->React.string
    | list{"logout"} =>
      let _ = clearToken()
      <Loading />
    | _ => <HomePage />
    }
  }
}
