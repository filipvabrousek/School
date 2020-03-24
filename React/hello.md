
# React

```js
class Hello extends React.Component {
	render(){
	  return <h1>Hello</h1>;
	}
}

ReactDOM.render(
<Hello/>,
document.querySelector("#root")
);
```


## Props
```js
class App extends React.Component{
    render(){
        return <h1>{`Hello ${this.props.name}!`}</h1>
    }
}

ReactDOM.render(
  <App name="Filip"/>,
  document.querySelector("#root")
);
```
        
