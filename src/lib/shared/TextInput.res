@react.component
let make = (~id, ~placeholder, ~domProps) => {
    <input {...domProps} id className="bg-ground border border-accent p-2.5 text-sm rounded hover:border-highlight" 
        placeholder type_="text" />
}