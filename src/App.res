@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()
  let (token, setToken) = React.useState(_ => Utils.getFromLocalStorage(TokenContext.tokenKey))
  let (userRequestData, setUserRequestData) = React.useState(_ => ApiRequest.NotAsked)

  let storeToken = newToken => {
    setToken(_ => newToken)
    newToken
    ->Belt.Option.map(newToken => Utils.setLocalStorage(TokenContext.tokenKey, newToken))
    ->ignore
  }

  React.useEffect1(_ => {
    switch token {
    | None | Some("") => ()
    | Some(t) => () //TODO: Call get user profile API
    }
    None
  }, [token])

  <div className="p-6">
    <TokenContext.Provider value={token, setToken: storeToken}>
      <p> {token->Belt.Option.getWithDefault("-")->React.string} </p>
      {switch userRequestData {
      | NotAsked | Loading(None) => <Loading />
      | LoadFailed(errorMessage) => <NonMemberArea />
      | Loading(Some(user)) | LoadSuccess(user) => <MemberArea />
      }}
    </TokenContext.Provider>
  </div>
}
