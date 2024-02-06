@react.component
let make = () => {
  let (token, setToken) = React.useState(_ => Utils.getFromLocalStorage(TokenContext.tokenKey))
  let (userRequestData, setUserRequestData) = React.useState(_ => ApiRequest.NotAsked)

  let storeToken = newToken => {
    setToken(_ => newToken)
    newToken
    ->Belt.Option.map(newToken => Utils.setLocalStorage(TokenContext.tokenKey, newToken))
    ->ignore
  }

  React.useEffect(_ => {
    switch token {
    | None | Some("") => setUserRequestData(_ => LoadFailed(""))
    | Some(tokenKey) =>
      ApiAuth.user(~token=tokenKey)
      ->Promise.then(result => {
        switch result {
        | Ok(user) => setUserRequestData(_ => LoadSuccess(user))
        | Error(errorMessage) => setUserRequestData(_ => LoadFailed(errorMessage))
        }->Promise.resolve
      })
      ->ignore
    }

    None
  }, [token])

  let optUser: option<User.t> = switch userRequestData {
  | LoadSuccess(user) | Loading(Some(user)) => Some(user)
  | _ => None
  }

  let setUser = updatedOptUser => {
    switch updatedOptUser {
    | None => ()
    | Some(updatedUser) => setUserRequestData(_ => LoadSuccess(updatedUser))
    }
  }

  <PageLayout>
    <TokenContext.Provider value={token, setToken: storeToken}>
      <UserContext.Provider value={user: optUser, setUser}>
        {switch userRequestData {
        | NotAsked | Loading(None) => <Loading />
        | LoadFailed(_errorMessage) => <NonMemberArea />
        | Loading(Some(_user)) | LoadSuccess(_user) => <MemberArea />
        }}
      </UserContext.Provider>
    </TokenContext.Provider>
  </PageLayout>
}
