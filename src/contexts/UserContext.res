type contextValue = {
  setUser: option<User.t> => unit,
  user: option<User.t>,
}
let initValue: contextValue = {
  setUser: _ => ignore(),
  user: None,
}

let context = React.createContext(initValue)

let getContext = () => React.useContext(context)

module Provider = {
  let make = React.Context.provider(context)
}
