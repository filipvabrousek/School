/*many libraries needed !!!!!!
https://npmcdn.com/react@15.3.1/dist/react.js
https://npmcdn.com/react-dom@15.3.1/dist/react-dom.js
https://npmcdn.com/babel-core@5.8.38/browser.min.js
*/
var HW = React.createClass({
  render: function() {
    return (
      <p>
      It is {this.props.date.toTimeString()}
        </p>
    );
  }
});

setInterval(function(){
  ReactDOM.render(
  <HW date = {new Date()}/>,
  
   document.querySelector('#ex')
   );
}, 600);
