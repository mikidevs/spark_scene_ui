@react.component
let make = () => {
    let push = RescriptReactRouter.push

    <div className="bg-ground h-screen">
        <h1 className="text-2xl w-fit mx-auto mb-6">{ React.string("Welcome to Spark Scene") }</h1>
        <ul className="flex flex-col gap-6">
            <button className="spark-btn" type_="button" onClick={(_) => push("/login")}>
                { React.string("Login") }
            </button>
            <button className="spark-btn" type_="button" onClick={(_) => push("/register")}>
                { React.string("Register") }
            </button>
        </ul>
    </div>
}