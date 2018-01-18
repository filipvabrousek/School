class FoodCalculator extends React.Component {
	constructor(props) {
		super(props);
		this.state = {
			color: props.initialColor,
			amount: 150
		};
	}
	handleChange(event) {
		const usr_input = event.target.value;
		if (isNaN(usr_input)) {
			console.log(usr_input);
		} else {
			this.setState({ amount: event.target.value });
		}
	}
	render() {
		
		return (
			<div>
				<p>
					<label htmlFor="value">Enter vegetable weight in g  here</label>
					<br />
					<input
						id="value"
						type="text"
						name="initvalue"
						autoComplete="off"
						value={this.state.amount}
						onChange={this.handleChange.bind(this)}
					/>
				</p>
				<div className="output">
					You will need
					<span className="water">{Math.round(this.state.amount / 150 * 30)}</span>
					ml of water
					<span className="oil">{Math.round(this.state.amount / 150 * 10)}</span>
					<span>
						ml of oil
					</span>
				</div>
			</div>
		);
	}
}
ReactDOM.render(<FoodCalculator />, document.querySelector("#container"));
