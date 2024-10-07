type labelledInputProps<'errors> = {
    id: string,
    label: string,
    type_: string,
    placeholder: string,
    fieldError: option<ReactHookForm.fieldError>,
    errorMessages: ReactHookForm.fieldError => Jsx.element,
    register: JsxDOM.domProps
}

external convert: unit => JsxDOM.domRef= "%identity"

@react.component(: labelledInputProps<'a>)
let make = (~id, ~label, ~placeholder, ~type_, ~fieldError, ~errorMessages, ~register) => {

    let ref = switch register.ref {
        | Some(ref) => ref
        | None => convert(())
    }

    <div className="relative">
        <label htmlFor=id className="block pb-2">{ React.string(label) }</label>
        <input { ...register }
            id placeholder type_ ref
            className={"spark-input " ++ { switch fieldError {
                | Some(_) => "!border-error focus:outline-error"
                | None => ""
            }}}
        />
        {
            switch fieldError {
                | Some(error) => {errorMessages(error)}
                | None => <></> 
            }
        }
    </div>
}