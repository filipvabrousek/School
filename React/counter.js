class Counter extends React.Component{
    constructor(props){
        super(props);
        
        this.state = {
            count: 0
        };
        
        this.work = this.work.bind(this);
    }
    
    work(){
       
       this.setState({
             count: this.state.count + 1
        });
       
    }
    
   render(){
        return (
            <div>
            <h1>{this.state.count}</h1>
                <button onClick= {this.work}>Working</button>
            </div>)
    }
}
                                    
ReactDOM.render(                         
   <Counter/>,
    document.querySelector("#root")
);