var React = require('react'),
    ErrorStore = require('../stores/error');

var Error = React.createClass({
  getInitialState: function() {
    return ({ error: "" });
  },

  componentDidMount: function() {
    ErrorStore.addListener(this.change);
  },

  componentWillUnmount: function() {
    ErrorStore.resetError();
  },

  change: function () {
    if (ErrorStore.fetch()) {
      this.setState({ error: "Invalid inputs"});
    }
  },

  render: function() {
    return (<p>{this.state.error}</p>);
  }

});

module.exports = Error;
