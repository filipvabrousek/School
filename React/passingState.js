class Inner extends React.Component { 
    render(){
        return <button onClick= {this.props.onClick}>{`Magic of React: ${this.props.count}`}</button>
    }
}


class Outer extends React.Component {
    constructor(props){
        super(props)
        this.state = {count: 0}
        this.handle = this.handle.bind(this);
    }
    
    handle(){
         this.setState(state => ({
            count: state.count + 1
        }));
        //alert(state.count);
    }
    
    render(){
       return( 
           <div>  
           <h2>{this.state.count} times.</h2>
           <Inner onClick= {this.handle} count = {this.state.count}/>
               </div>
               );
    }
}


ReactDOM.render(
        <Outer/>,
  document.querySelector("#root")
);
