let fn = (~on: option<'a>, extract: 'a => Jsx.element) => {
    switch on {
        | Some(data) => extract(data)
        | None => <></>
    }
}