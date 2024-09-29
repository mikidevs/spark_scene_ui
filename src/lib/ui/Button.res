@react.component
let make = (~type_, ~onClick=?, ~children) => {
    let onClick = switch onClick {
        | Some(onClick) => onClick
        | None => (_) => ()
    }

    <button type_ className="w-32 py-3 mx-auto bg-cyan-600 font-medium rounded-lg text-md border border-accent focus:outline-none focus:ring-gray-700 hover:bg-cyan-800"
        onClick
    >{
       children
    }</button>
}