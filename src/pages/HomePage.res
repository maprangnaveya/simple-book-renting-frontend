open Mui

@react.component
let make = () => {
  <PageLayout>
    <h1> {`Hello, UserA`->React.string} </h1>
    <RecommendedBookContainer />
    <AllBooksContainer />
  </PageLayout>
}
