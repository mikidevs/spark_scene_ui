@react.component
let make = (~type_, ~onClick=?, ~children) => {
    let onClick = switch onClick {
        | Some(onClick) => onClick
        | None => (_) => ()
    }

    <button type_ className="w-28 py-2 mx-auto bg-primary font-medium rounded-lg text-md text-dark border border-secondary focus:outline-none hover:bg-secondary"
        onClick
    >{
       children
    }</button>
}