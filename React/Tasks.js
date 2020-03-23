import React from 'react';
import ReactDOM from 'react-dom';
import * as serviceWorker from './serviceWorker';

// To-Do List
class Input extends React.Component {
    constructor(props){
        super(props);
    }
   
	add(){	
		console.log("Item added.")
	}
	
    render(){
        return (
            <div>
            <h1>Tasks</h1>
                <input type="text" placeholder="Add a task"/><br></br>
            <button onClick={this.add}>Add a task</button>
            </div>
        );
    }
}


class TaskList extends React.Component {
    constructor(p){
        super(p);
        this.state = {tasks: ["Item 1", "Item 2", "Item 3"]}
    }
    
    render(){
       return this.state.tasks.map(n => <li>{n}</li>);
    }
}
                                   
         

class Tasks extends React.Component {	
		
		render(){
			return (
				<div>
				<Input/>
				<TaskList/>
				</div>
			)
		}
}		
                                
ReactDOM.render(
<Tasks/>,
document.querySelector("#root")
);
