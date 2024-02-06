@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  {
    switch url.path {
    | list{"login"} => <LoginPage />
    | list{"register"} => "Register"->React.string
    | _ => <HomePage />
    }
  }
}
