type event = {
    target: unknown,
    type_?: unknown
}

type options = {
    onChange?: event => promise<unit>,
    onBlur?: event => promise<unit>,
    ref?: unknown => unit,
    min?: int,
    max?: int,
    maxLength?: int,
    minLength?: int,
    pattern?: string,
    required?: bool,
    disabled?: bool,
    validate?: string => bool
}

type fieldError = {
    message?: string,
    @as("type") type_: string,
    ref?: unknown,
}

type formState<'errors> = {
    isDirty: bool,
    isSubmitted: bool,
    isLoading: bool,
    isValid: bool,
    errors: 'errors
}

type submitHandler<'data> = ('data) => unit 

type submitErrorHandler<'errors> = (~errors: 'errors, ~event: event=?) => unknown

type useFormRegister = (~name: string, ~options: options=?) => JsxDOMU.domProps

type useFormReturn<'data, 'errors> = {
    register: useFormRegister,
    watch: string => string,
    formState: formState<'errors>,
    handleSubmit: (~onValid: submitHandler<'data>, ~onInvalid: submitErrorHandler<'errors>=?) => JsxEventU.Mouse.t => unit
}

@module("react-hook-form") 
external useForm: unit => useFormReturn<'data, 'errors> = "useForm"