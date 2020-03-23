function Border(props){
    return (
    <div className='border'>
            {props.children}
    </div>
    );
}

class Compose extends React.Component{
    render(){
        return (
            <Border>
            <h1>{`Hello ${this.props.name}!`} </h1>
            </Border>
        );
    }
}

ReactDOM.render(
    <Compose name="Filip"/>,
  document.querySelector("#root")
);