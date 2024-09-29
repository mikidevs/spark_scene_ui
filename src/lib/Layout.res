@react.component
let make = (~children: React.element) => {
    let push = RescriptReactRouter.push

    <div className="bg-ground h-screen">
        <header className="sticky top-0 flex-none w-full mx-auto bg-surface border-b border-accent">
            <div className="flex items-center justify-between w-full px-12 py-3">
                <div className="flex items-center">
                    <h1 className="text-xl">{React.string("Spark Scene")}</h1>
                </div>
                <div className="flex items-center">
                    <ul className="flex flex-row gap-2">
                        <li className="px-2 text-sm font-medium"
                            onClick={(_) => push("/dashboard")}
                        >
                            {React.string("Dashboard")}
                        </li>
                        <li className="text-sm font-medium"
                            onClick={(_) => push("/users")}
                        >
                            {React.string("Users")}
                        </li>
                    </ul>
                </div>
            </div>
        </header>
        <div className="w-full px-12 mx-auto">children</div>
    </div>
}