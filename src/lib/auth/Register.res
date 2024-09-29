module Fetch = {
    type response

    @send external json: response => Js.Promise.t<'a> = "json"
    @val external fetch: string => Js.Promise.t<response> = "fetch"
}

let apiUrl = "http://localhost:8000/api/test"
type test = { message: string }

let doTest = (_): Js.Promise.t<test> => {
    Fetch.fetch(apiUrl) -> Promise.then(Fetch.json)
}

// type register = {full_name: string, email: string, password: string}

@react.component
let make = () => {
    let {status, data} = ReactQuery.useQuery({
        queryKey: [],
        queryFn: doTest
    })

    <div className="bg-ground h-screen flex items-center justify-center">
        <div>{
            switch status {
                | Pending => "Loading..." -> React.string
                | Success => `Message is ${data.message}` -> React.string
                | _ => "Unexpected Error" -> React.string
            }
        }</div>
        <div className="bg-surface p-5 rounded">
            <div className="font-bold pb-3 mb-5 border-b border-accent">
                { React.string("Register") }
            </div>
            <form className="grid grid-cols-2 gap-4 pb-5">
                <div>
                    <label htmlFor="username" className="block">{ React.string("Username") }</label>
                    <input type_="text" />
                </div>
                <div>
                    <label htmlFor="email" className="block">{ React.string("Email") }</label>
                    <input type_="text" />
                </div>
                <div>
                    <label htmlFor="password" className="block">{ React.string("Password") }</label>
                    <input type_="password" placeholder="•••••••••" />
                </div>
                <div>
                    <label htmlFor="confirm-password" className="block">{ React.string("Confirm Password") }</label>
                    <input type_="password" placeholder="•••••••••" />
                </div>
            </form>
            <Button type_="submit">
                { Jsx.string("register") }
            </Button>
        </div>
    </div>
}