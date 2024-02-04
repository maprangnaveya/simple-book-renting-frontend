let tokenKey = "srb-token"
type contextValue = {
  setToken: option<string> => unit,
  token: option<string>,
}
let initValue: contextValue = {
  setToken: newToken => {
    newToken
    ->Belt.Option.map(newToken => Utils.setLocalStorage(tokenKey, newToken))
    ->ignore
  },
  token: Utils.getFromLocalStorage(tokenKey),
}

let context = React.createContext(initValue)

module Provider = {
  let make = React.Context.provider(context)
}
