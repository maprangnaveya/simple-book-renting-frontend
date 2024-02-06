open Mui

@react.component
let make = (~className: string="", ~maxWidth="1200px", ~padding="none", ~children) => {
  let {user: optUser} = UserContext.getContext()

  <div className={`page-layout pt-6 ${className}`}>
    <div className="page-layout-navbar">
      <div className="navbar-container">
        <Link href=Links.home underline=Link.Hover>
          <p className="text-xl"> {"Simple Renting Book"->React.string} </p>
        </Link>
        <div className="navbar-menu">
          {switch optUser {
          | None =>
            <Link href=Links.login>
              <img src="/images/icons/login.svg" />
            </Link>
          | Some(_) =>
            <>
              <Link href=Links.setting>
                <img src="/images/icons/setting.svg" />
              </Link>
              <Link href=Links.logout>
                <img src="/images/icons/logout.svg" />
              </Link>
            </>
          }}
        </div>
      </div>
    </div>
    <div
      className="page-layout-content"
      style={ReactDOM.Style.make(~maxWidth, ~margin="auto", ~display="flex", ~padding, ())}>
      <div className="page-layout-children"> {children} </div>
    </div>
  </div>
}
