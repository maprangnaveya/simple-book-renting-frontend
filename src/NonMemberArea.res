@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  {
    switch url.path {
    | list{"login"} => <LoginPage />
    | list{"register"} => "Register"->React.string
    | list{"books", _} => "Please Login to View Book Detail"->React.string
    | _ => <HomePage />
    }
  }
}
