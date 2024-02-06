open Mui

@react.component
let make = () => {
  <PageLayout>
    <Stack spacing=Stack.Number(3.)>
      <p className="text-3xl"> {`Hello, M`->React.string} </p>
      <RecommendedBookContainer />
      <AllBooksContainer />
    </Stack>
  </PageLayout>
}
