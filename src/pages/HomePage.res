open Mui

@react.component
let make = () => {
  let {user: optUser} = UserContext.getContext()
  let userFirstName = optUser->Belt.Option.mapWithDefault("User", ({firstName}) => firstName)

  <Stack spacing=Stack.Number(3.)>
    <p className="text-3xl"> {`Hello, ${userFirstName}`->React.string} </p>
    <RecommendedBookContainer />
    <AllBooksContainer />
  </Stack>
}
