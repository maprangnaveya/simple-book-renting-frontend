type props = {
  ...Mui.Card.props,
  onMouseEnter?: ReactEvent.Mouse.t => unit,
  onMouseLeave?: ReactEvent.Mouse.t => unit,
  onClick?: ReactEvent.Mouse.t => unit,
  @as("aria-owns") ariaOwns?: string,
}

@module("@mui/material/Card")
external make: React.component<props> = "default"
