open Mui

@react.component
let make = () => {
  <Box component={OverridableComponent.string("form")} className="login-form">
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
      />
      <TextField
        type_="password"
        id="login-new-password"
        autoComplete="new-password"
        required=true
        fullWidth=true
        placeholder="Password"
        margin=FormControl.Dense
      />
      <Button variant=Button.Outlined> {"Login"->React.string} </Button>
      // TODO: <Link href="/forgotpassword" variant=Typography.Body2>{"Forgot your password?"->React.string} </Link>
      <Link href="/register" variant=Typography.Body2>
        {"Don't have an account? Get Started"->React.string}
      </Link>
    </FormControl>
  </Box>
}
