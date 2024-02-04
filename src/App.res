@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()
  let (token, setToken) = React.useState(_ => Utils.getFromLocalStorage(TokenContext.tokenKey))

  let storeToken = newToken => {
    setToken(_ => newToken)
    newToken
    ->Belt.Option.map(newToken => Utils.setLocalStorage(TokenContext.tokenKey, newToken))
    ->ignore
  }

  <div className="p-6">
    <TokenContext.Provider value={token, setToken: storeToken}>
      <p> {token->Belt.Option.getWithDefault("-")->React.string} </p>
      {{
        switch url.path {
        | list{} | list{""} => "Home"
        | _ => "Not Found"
        }
      }->React.string}
    </TokenContext.Provider>
  </div>
}
