let authUrl = `${Env.api_url}/api/v1/auth`
let profileUrl = `${Env.api_url}/api/v1/profile`

let loginPath = `${authUrl}/login/`
let profilePath = `${profileUrl}/me/`

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

let user = (~token) => {
  RequestUtils.request(~url=profilePath, ~method=RequestUtils.GET, ~token, ~decode=User.Decode.t)
}
