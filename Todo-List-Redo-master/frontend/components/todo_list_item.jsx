var React = require('react');

var TodoListItem = React.createClass({
  getInitialState: function() {
    return { todo: this.props.todo }
  },

  toggleDone: function() {
    console.log("hey")
  },

  update: function(e) {
    e.preventDefault();
  },

  delete: function(e) {
    e.preventDefault();
  },

  render: function() {
    return(
      <li>
        <h1>
          {this.state.todo.title}
        </h1>
        <p>
          {this.state.todo.body}
        </p>
        <div onClick={this.toggleDone}>
          {String(this.state.todo.done)}
        </div>
        <button onClick={this.update}>Update</button>
        <button onClick={this.delete}>Delete</button>
      </li>
    );
  }


});

module.exports = TodoListItem;
