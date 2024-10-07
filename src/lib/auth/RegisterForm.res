module RegisterUser = {
    let apiUrl = "http://localhost:8000/api/test"

    type t = {
        fullName: string,
        email: string,
        password: string,
        confirmPassword: string
    }

    type errors = {
        fullName?: ReactHookForm.fieldError,
        email?: ReactHookForm.fieldError,
        password?: ReactHookForm.fieldError,
        confirmPassword?: ReactHookForm.fieldError
    }

    let registerUserToJson = (registerUser: t) => JSON.Object(
        Dict.fromArray([
            ("fullName", JSON.String(registerUser.fullName)),
            ("email", JSON.String(registerUser.email)),
            ("password", JSON.String(registerUser.password))
        ])
    )

    let register = (register: t): promise<Ky.Response.t> => {
        Ky.post(apiUrl, ~options={ json: register -> registerUserToJson })
    }
}

@react.component
let make = () => {
    let push = RescriptReactRouter.push

    let {isPending, isError, mutate} = ReactQuery.useMutation({
        mutationFn: RegisterUser.register,
    })

    let useForm: ReactHookForm.useFormReturn<RegisterUser.t, RegisterUser.errors> = ReactHookForm.useForm()
    let { register, watch, formState: { errors }, handleSubmit } = useForm

    let currentPassword = watch("password")

    let onSubmit: ReactHookForm.submitHandler<RegisterUser.t> = registerUser => mutate(registerUser)

    <div className="bg-ground h-screen flex items-center justify-center">
        <div className="bg-surface w-1/4 p-5 rounded">
            <div className="font-bold text-4xl mb-5">
                { React.string("Create an account") }
            </div>
            <div className="mb-5 text-grey">
                { React.string("Already have an account? ")} 
                <a className="spark-link" onClick={ (_) => push("/login") }>{ React.string("Log in") }</a>
            </div>
            <form className="flex flex-col gap-6 pb-5">
                <LabelledInput 
                    id="full-name" label="User Name" placeholder="Name Surname" type_="text"
                    fieldError=errors.fullName register=register(~name="fullName", ~options={ required: true })
                    errorMessages={ error =>
                        <BooleanGuard on={ error.type_ === "required" }>
                            <p className="spark-error absolute top-18">{ React.string("User name is required") }</p>
                        </BooleanGuard>
                    }
                />
                <LabelledInput 
                    id="email" label="Email" placeholder="email@example.com" type_="email"
                    fieldError=errors.email register=register(~name="email", ~options={ required: true })
                    errorMessages={ error =>
                        <BooleanGuard on={ error.type_ === "required" }>
                            <p className="spark-error absolute top-18">{ React.string("Email is required") }</p>
                        </BooleanGuard>
                    }
                />
                <LabelledInput 
                    id="password" label="Password" placeholder="•••••••••" type_="password"
                    fieldError=errors.password register=register(~name="password", ~options={ required: true, minLength: 8 })
                    errorMessages={ error =>
                        <BooleanGuard on={ error.type_ === "required" }>
                            <p className="spark-error absolute top-18">{ React.string("Password is required") }</p>
                        </BooleanGuard>
                    }
                />
                <LabelledInput 
                    id="confirm-password" label="Confirm Password" placeholder="•••••••••" type_="password"
                    fieldError=errors.password
                    register=register(~name="confirmPassword", ~options={ required: true, minLength: 8, validate: {
                        (confirm) => currentPassword === confirm 
                    }})
                    errorMessages={ error =>
                        <BooleanGuard on={ error.type_ === "required" }>
                            <p className="spark-error absolute top-18">{ React.string("Confirm password is required") }</p>
                        </BooleanGuard>
                    }
                />
            </form>
            { if (isPending) {
                Jsx.string("Registering user...")
            } else {
                <>
                    { isError ? <div> { Jsx.string("An error occured!") } </div> : <></> }
                    <button className="spark-btn" type_="button" onClick={ handleSubmit(~onValid=onSubmit) }>
                        { Jsx.string("Create account") }
                    </button>
                </>
            }}
        </div>
    </div>
}