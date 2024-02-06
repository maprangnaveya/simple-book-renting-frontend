open Mui

type loginApiRequest = ApiRequest.t<bool, option<string>>

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
  let {setToken} = TokenContext.getContext()
  let (state, dispatch) = React.useReducer(
    reducer,
    {email: "", password: "", loginApiRequest: ApiRequest.NotAsked},
  )
  let isLoading = ApiRequest.isLoading(state.loginApiRequest)

  <form
    className="login-form"
    onSubmit={e => {
      ReactEvent.Form.preventDefault(e)

      RequestLogin(ApiRequest.Loading(None))->dispatch

      ApiAuth.login(~email=state.email, ~password=state.password)
      ->Promise.then((result: result<string, string>) => {
        switch result {
        | Ok(token) =>
          RequestLogin(ApiRequest.LoadSuccess(true))->dispatch

          setToken(Some(token))
        | Error(errorMsg) => RequestLogin(ApiRequest.LoadFailed(Some(errorMsg)))->dispatch
        }->Promise.resolve
      })
      ->Promise.catch(_err => {
        RequestLogin(ApiRequest.LoadFailed(None))
        ->dispatch
        ->Promise.resolve
      })
      ->ignore
    }}>
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
      <Link href=Links.register variant=Typography.Body2>
        {"Don't have an account? Get Started"->React.string}
      </Link>
    </FormControl>
    {switch state.loginApiRequest {
    | Loading(_) => <Loading />
    | LoadFailed(optErrorMessage) =>
      <Typography variant=Typography.Body2>
        {optErrorMessage
        ->Belt.Option.getWithDefault("Something went wrong, please try again")
        ->React.string}
      </Typography>
    | _ => React.null
    }}
  </form>
}
