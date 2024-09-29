@react.component
let make = () => {
    let push = RescriptReactRouter.push

    <div className="bg-ground h-screen">
        <h1 className="text-2xl w-fit mx-auto mb-6">{ React.string("Welcome to Spark Scene") }</h1>
        <ul className="flex flex-col gap-6">
            <Button 
                type_="button"
                onClick={(_) => push("/login")}
            >
                { React.string("Login") }
            </Button>
            <Button
                type_="button"
                onClick={(_) => push("/register")}
            >
                { React.string("Register") }
            </Button>
        </ul>
    </div>
}