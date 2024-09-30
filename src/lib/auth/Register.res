// let apiUrl = "http://localhost:8000/api/test"
// type test = { message: string }

// let doTest = (_): promise<test> => {
//     Fetch.fetch(apiUrl) -> Promise.then(Fetch.json)
// }

type register = {
    fullName: string,
    email: string,
    password: string,
    confirmPassword: string
}

@react.component
let make = () => {
    // let {status, data} = ReactQuery.useQuery({
    //     queryKey: [],
    //     queryFn: doTest
    // })

    let { register: register, handleSubmit } = ReactHookForm.useForm()
    let onSubmit: ReactHookForm.submitHandler<register> = register => Js.Console.log(register)

    <div className="bg-ground h-screen flex items-center justify-center">
        // <div>{
        //     switch status {
        //         | Pending => "Loading..." -> React.string
        //         | Success => `Message is ${data.message}` -> React.string
        //         | _ => "Unexpected Error" -> React.string
        //     }
        // }</div>
        <div className="bg-surface p-5 rounded">
            <div className="font-bold text-xl pb-5 mb-5 border-b border-accent">
                { React.string("Register") }
            </div>
            <form className="grid grid-cols-2 gap-5 pb-5">
                <div>
                    <label htmlFor="full-name" className="block pb-2">{ React.string("Name") }</label>
                    <TextInput id="full-name" placeholder="Name" domProps={ register(~name="fullName", ~options={ required: true, maxLength: 20 }) }/>
                </div>
                <div>
                    <label htmlFor="email" className="block pb-2">{ React.string("Email") }</label>
                    <TextInput id="email" placeholder="Email" domProps={ register(~name="email", ~options={ required: true }) }/>
                </div>
                <div>
                    <label htmlFor="password" className="block pb-2">{ React.string("Password") }</label>
                    <PasswordInput id="password" domProps={ register(~name="password", ~options={ required: true, minLength: 8 })} />
                </div>
                <div>
                    <label htmlFor="confirm-password" className="block pb-2">{ React.string("Confirm Password") }</label>
                    <PasswordInput id="confirm-password" domProps={ register(~name="confirmPassword", ~options={ required: true, minLength: 8 })} />
                </div>
            </form>
            <Button type_="button" onClick={ handleSubmit(~onValid=onSubmit) }>
                { Jsx.string("Register") }
            </Button>
        </div>
    </div>
}