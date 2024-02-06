open Mui

@react.component
let make = (
  ~className: string="",
  ~maxWidth="1200px",
  ~padding="none",
  ~isShowLogout=true,
  ~children,
) => {

  <div className={`page-layout pt-6 ${className}`}>
    <div className="page-layout-navbar">
      <div className="navbar-container">
        <Link href=Links.home>
          <img src="/images/logo.png" className="page-navbar-logo" />
        </Link>
        <div className="navbar-menu">
          <Link href=Links.setting>
            <img src="/images/icons/setting.svg" />
          </Link>
          {isShowLogout
            ? <Link href=Links.logout>
                <img src="/images/icons/logout.svg" />
              </Link>
            : React.null}
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
