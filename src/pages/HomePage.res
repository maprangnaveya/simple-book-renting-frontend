@react.component
let make = () => {
  <div>
    <Sidebar />
    <div>
      <h1> {`Hello, UserA`->React.string} </h1>
      <AllBooksContainer />
    </div>
  </div>
}
