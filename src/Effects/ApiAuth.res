let authUrl = `${Env.api_url}/api/v1/auth`

let loginPath = `${authUrl}/login/`

module Decode = {
  open! Json.Decode

  let token = field("token", string)
}

let login = (~email: string, ~password: string) => {
  let body = {
    "email": email,
    "password": password,
  }

  RequestUtils.request(~url=loginPath, ~method=RequestUtils.POST, ~body, ~decode=Decode.token)
}
