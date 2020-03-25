class LogIn extends React.Component {
	constructor(text){
		super(text);
		this.state = {email: "", password: ""}
		
		firebase.auth().onAuthStateChanged(function(user) {
		if (user) {
		window.open("group.html", "_top");
		}
		 });
		}
	emailChanged = (e) => {
		console.log(e.target.value);
		this.setState({email: e.target.value});
	}
	
	passChanged = (e) => {
		console.log(e.target.value);
		this.setState({password: e.target.value});
	}
	
	login = (e) => {
		let email = this.state.email;
		let password = this.state.password;
		
		if (email.length > 0 && password.length > 0) {    
        firebase.auth().signInWithEmailAndPassword(email, password).catch(err => {
            S("#existerr").innerHTML = "";
					S("#existerr").innerHTML = err;// "Account does not exist!";
                    S("#existerr").style.display = "block";
        });
	} else {
		alert("You must fill-in all fields.");
	}
	}
	
	signUp = (e) => {
		window.open("signup.html");
	}
	
	render(){
		return (
			<div id="back">
			<div id="existerr"></div>
			<h1>Swimrun World</h1>
			<div id="login">
			<input type={"text"} onChange = {this.emailChanged} placeholder="E-mail"/>
	    		<input type={"password"} onChange = {this.passChanged} placeholder="password"/> <br></br>
			<button id={"loginb"} onClick={this.login}>Log in</button><br></br>
			<button id={"toSignup"} onClick={this.signUp}>Sign up</button>
			</div>
			</div>
		);
	}
}


ReactDOM.render(
<LogIn/>,
S("#render")
);


function S(el) {
	return document.querySelector(el);
}
