@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  {
    switch url.path {
    | list{} => "Home"->React.string
    | list{"login"} => <LoginPage />

    | list{"register"} => "Register"->React.string
    | _ => "Not found"->React.string
    }
  }
}
