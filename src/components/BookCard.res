open Mui
@get
external currentTarget: 'event => Dom.element = "currentTarget" /* Should return Dom.eventTarget */
@react.component
let make = (~book: Book.t) => {
  let (anchorEl, setAnchorEl) = React.useState(_ => Js.Nullable.null)

  let elementId = {`mouse-over-popover-${book.isbn}`}
  let isOpen = !Js.Nullable.isNullable(anchorEl)

  let handlePopoverClose = _ => {
    setAnchorEl(_ => Js.Nullable.null)
  }

  let handlePopoverOpen = e => {
    ReactEvent.Mouse.stopPropagation(e)
    let target = currentTarget(e)
    if Js.Nullable.isNullable(anchorEl) {
      setAnchorEl(_ => Js.Nullable.return(target))
    } else {
      handlePopoverClose()
    }
  }

  <MuiCardCustom
    className="book-card"
    onMouseEnter={handlePopoverOpen}
    onMouseLeave={handlePopoverClose}
    ariaOwns=?{isOpen ? Some(elementId) : None}>
    <CardContent>
      <Image image=book.imageUrl alt={`book-card-${book.isbn}`} />
    </CardContent>
    <Popover
      id=elementId
      open_={isOpen}
      anchorEl={Popover.Element(_ => anchorEl)}
      anchorOrigin={{
        vertical: Popover.Bottom,
        horizontal: Popover.Center,
      }}
      transformOrigin={{
        vertical: Popover.Top,
        horizontal: Popover.Center,
      }}
      onClose={(_, _) => handlePopoverClose()}
      disableRestoreFocus=true>
      <Typography sx={Sx.obj({p: System.Value.Number(1.)})}>
        {`${book.title}`->React.string}
      </Typography>
    </Popover>
  </MuiCardCustom>
}
