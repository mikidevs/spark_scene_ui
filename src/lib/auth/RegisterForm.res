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
    let { register, formState: { errors }, handleSubmit } = useForm

    React.useEffect(() => {
        Console.log(errors)
        None
    }, [errors])

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
                <div className="relative">
                    <label htmlFor="full-name" className="block pb-2">{ React.string("User Name") }</label>
                    <input { ...register(~name="fullName", ~options={ required: true }) }
                        id="full-name"  placeholder="Name Surname" type_="text" 
                        className={"spark-input " ++ { switch errors.fullName {
                            | Some(_) => "!border-error focus:outline-error"
                            | None => ""
                        }}}
                    />
                    {
                        OptionGuard.fn(~on=errors.fullName, (error) => {
                            <BooleanGuard on={ error.type_ === "required" }>
                                <p className="spark-error absolute top-18">{React.string("User name is required")}</p>
                            </BooleanGuard>
                        })
                    }
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
                        { Jsx.string("Create account") }
                    </button>
                </>
            }}
        </div>
    </div>
}