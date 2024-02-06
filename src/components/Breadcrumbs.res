type breadcrumb = {
  href: string,
  label: string,
}
@react.component
let make = (~breadcrumbs: array<breadcrumb>, ~current: string) => {
  <Mui.Breadcrumbs>
    {breadcrumbs
    ->Belt.Array.mapWithIndex((idx, {href, label}) =>
      <LinkCustom
        key={`breadcrumb-${Belt.Int.toString(idx)}-${href}`} underline=Mui.Link.Hover href>
        {label->React.string}
      </LinkCustom>
    )
    ->React.array}
    <Mui.Typography color=Mui.System.Value.TextPrimary> {current->React.string} </Mui.Typography>
  </Mui.Breadcrumbs>
}
