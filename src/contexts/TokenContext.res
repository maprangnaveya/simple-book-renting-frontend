let tokenKey = "srb-token"
type contextValue = {
  clearToken: unit => unit,
  setToken: option<string> => unit,
  token: option<string>,
}
let initValue: contextValue = {
  clearToken: _ => ignore(),
  setToken: newToken => {
    newToken
    ->Belt.Option.map(newToken => Utils.setLocalStorage(tokenKey, newToken))
    ->ignore
  },
  token: Utils.getFromLocalStorage(tokenKey),
}

let context = React.createContext(initValue)

let getContext = () => React.useContext(context)

module Provider = {
  let make = React.Context.provider(context)
}
