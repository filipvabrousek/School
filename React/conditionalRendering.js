
function A(){
    return <h1>Welcome back!</h1>
}

function B(){
    return <h1>Sign up.</h1>
}

function Greeting(props){
    if (props.isIn){
        return <A/>
    } else {
        return <B/>
    }
}



ReactDOM.render(
 <Greeting isIn={false} />,
    document.querySelector("#root")
)
