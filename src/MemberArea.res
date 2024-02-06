@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  {
    switch url.path {
    | list{} => <HomePage />
    | list{"settings"} => "Settings"->React.string
    | _ => "Not found"->React.string
    }
  }
}
