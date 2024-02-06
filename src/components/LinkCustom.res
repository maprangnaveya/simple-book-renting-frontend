let handleClick = (href, target, event, isExternal) =>
  switch isExternal {
  | Some(true) => ()
  | _ =>
    switch target {
    | None
    | Some("") =>
      if !ReactEvent.Mouse.defaultPrevented(event) {
        ReactEvent.Mouse.preventDefault(event)
        RescriptReactRouter.push(href)
      }
    | _ => ()
    }
  }

@react.component
let make = (
  ~href: string,
  ~className: option<string>=?,
  ~target: option<string>=?,
  ~isExternal: option<bool>=?,
  ~variant: option<Mui.Typography.variant>=?,
  ~underline: option<Mui.Link.underline>=?,
  ~children,
) => {
  <Mui.Link
    href
    className={"link " ++ Js.Option.getWithDefault("link-default", className)}
    ?target
    ?variant
    ?underline
    onClick={event => handleClick(href, target, event, isExternal)}>
    children
  </Mui.Link>
}
