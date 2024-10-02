@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()
  let client = ReactQuery.QueryClient.make()

  <ReactQuery.QueryClientProvider client> {
    switch url.path {
      | list{} => <Landing/>
      | list{"register"} => <RegisterForm/>
      | list{"login"} => <Login/>
      | list{route} =>
        if (route === "not-found") {
          <div> { React.string("Not Found") } </div>
        } else {
          <Layout>
              {
                switch route {
                  | "dashboard" => { React.string("Dashboard")}
                  | "users" => { React.string("Users")}
                  | _ => {
                    RescriptReactRouter.push("/not-found")
                    <></>
                  }
                }
              }
          </Layout>
        }
      | _ => <></>
    }
  } </ReactQuery.QueryClientProvider>
}
