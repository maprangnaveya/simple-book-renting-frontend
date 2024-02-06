@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  {
    switch url.path {
    | list{} => <HomePage />
    | list{"login"} => <LoginPage />
    | list{"register"} => "Register"->React.string
    | _ => "Not found"->React.string
    }
  }
}
