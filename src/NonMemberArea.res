@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  {
    switch url.path {
    | list{} => "Home"->React.string
    | list{"login"} => "Login"->React.string
    | list{"register"} => "Register"->React.string
    | _ => "Not found"->React.string
    }
  }
}
