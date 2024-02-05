open Mui

type loginApiRequest = ApiRequest.t<bool, string>

type action = RequestLogin(loginApiRequest) | SetEmail(string) | SetPassword(string)

type state = {
  email: string,
  password: string,
  loginApiRequest: loginApiRequest,
}

let reducer = (state, action) => {
  switch action {
  | RequestLogin(loginApiRequest) => {...state, loginApiRequest}
  | SetEmail(email) => {...state, email}
  | SetPassword(password) => {...state, password}
  }
}

@react.component
let make = () => {
  let (state, dispatch) = React.useReducer(
    reducer,
    {email: "", password: "", loginApiRequest: ApiRequest.NotAsked},
  )
  let isLoading = ApiRequest.isLoading(state.loginApiRequest)

  <form className="login-form" onSubmit={e => ()}>
    <FormControl>
      <Typography> {"Sign In to Your Account"->React.string} </Typography>
      <TextField
        type_="email"
        id="login-email"
        autoComplete="email"
        required=true
        fullWidth=true
        placeholder="Email"
        margin=FormControl.Dense
        value=state.email
        onChange={e => Utils.getFormTargetValue(e)->SetEmail->dispatch}
      />
      <TextField
        type_="password"
        id="login-new-password"
        autoComplete="new-password"
        required=true
        fullWidth=true
        placeholder="Password"
        margin=FormControl.Dense
        value=state.password
        onChange={e => Utils.getFormTargetValue(e)->SetPassword->dispatch}
      />
      <Button type_=ButtonBase.Submit variant=Button.Outlined disabled=isLoading>
        {"Login"->React.string}
      </Button>
      // TODO: <Link href="/forgotpassword" variant=Typography.Body2>{"Forgot your password?"->React.string} </Link>
      <Link href="/register" variant=Typography.Body2>
        {"Don't have an account? Get Started"->React.string}
      </Link>
    </FormControl>
    {isLoading ? <Loading /> : React.null}
  </form>
}
