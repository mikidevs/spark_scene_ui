type registerUser = {
    fullName: string,
    email: string,
    password: string,
    confirmPassword: string
}


let registerUserToJson = (registerUser: registerUser) => JSON.Object(
    Dict.fromArray([
        ("fullName", JSON.String(registerUser.fullName)),
        ("email", JSON.String(registerUser.email)),
        ("password", JSON.String(registerUser.password))
    ])
)

let apiUrl = "http://localhost:8000/api/test"

let newUser = (register: registerUser): promise<Ky.Response.t> => {
    Ky.post(apiUrl, ~options={ json: register -> registerUserToJson })
}

@react.component
let make = () => {
    let {isPending, isError, isSuccess, mutate} = ReactQuery.useMutation({
        mutationFn: newUser,
    })

    let { register, handleSubmit } = ReactHookForm.useForm()
    let onSubmit: ReactHookForm.submitHandler<registerUser> = register => mutate(register)

    <div className="bg-ground h-screen flex items-center justify-center">
        <div className="bg-surface p-5 rounded">
            <div className="font-bold text-xl pb-5 mb-5 border-b border-accent">
                { React.string("Register") }
            </div>
            <form className="grid grid-cols-2 gap-5 pb-5">
                <div>
                    <label htmlFor="full-name" className="block pb-2">{ React.string("Name") }</label>
                    <input { ...register(~name="fullName", ~options={ required: true }) }
                        id="full-name" className="spark-input" placeholder="Name Surname" type_="text" />
                </div>
                <div>
                    <label htmlFor="email" className="block pb-2">{ React.string("Email") }</label>
                    <input { ...register(~name="email", ~options={ required: true }) }
                        id="email" className="spark-input" placeholder="email@example.com" type_="text" />
                </div>
                <div>
                    <label htmlFor="password" className="block pb-2">{ React.string("Password") }</label>
                    <input { ...register(~name="password", ~options={ required: true, minLength: 8 })}
                        id="password" className="spark-input" placeholder="•••••••••" type_="password" />
                </div>
                <div>
                    <label htmlFor="confirm-password" className="block pb-2">{ React.string("Confirm Password") }</label>
                    <input { ...register(~name="confirmPassword", ~options={ required: true, minLength: 8 })}
                        id="confirm-password" className="spark-input" placeholder="•••••••••" type_="password" />
                </div>
            </form>
            { if (isPending) {
                Jsx.string("Registering user...")
            } else {
                <>
                    { isError ? <div> { Jsx.string("An error occured!") } </div> : <></> }
                    <button className="spark-btn" type_="button" onClick={ handleSubmit(~onValid=onSubmit) }>
                        { Jsx.string("Register") }
                    </button>
                </>
            }}
        </div>
    </div>
}