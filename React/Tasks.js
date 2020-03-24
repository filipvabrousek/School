import React from 'react';
import ReactDOM from 'react-dom';
import * as serviceWorker from './serviceWorker';

// To-Do List
// 23/03/20 - new begin
// 24/03/20 - 17:57:00 Tasks do list

class Tasks extends React.Component {
    constructor(props){
        super(props);
		this.state = {value: "", tasks: []}
   	 }
	
	onChange = (e) => {
		this.setState({value: e.target.value});
	}
   
	add = (e) => {	
		this.state.tasks.push(this.state.value);
		this.setState({ tasks: this.state.tasks });
	}
	
    render(){
        return (
            <div>
            <input type="text" placeholder="Add a task" onChange={this.onChange}/><br></br>
            <button onClick={this.add}>Add a task</button>
		 {this.state.tasks.map(x => <h1>{`${x}`}</h1>)}
            </div>
        );
    }
}


ReactDOM.render(
<Tasks/>,
document.querySelector("#root")
);
