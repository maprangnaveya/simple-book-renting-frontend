type t<'content, 'error> =
  NotAsked | Loading(option<'content>) | LoadSuccess('content) | LoadFailed('error)
