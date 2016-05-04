var React = require('react'),
    TodoStore = require('../stores/todo_store.js'),
    TodoListItem = require('./todo_list_item'),
    LinkedStateMixin = require('react-addons-linked-state-mixin');

var TodoList = React.createClass({
  mixins: [LinkedStateMixin],

  getInitialState: function() {
    return { todos: TodoStore.all(),
             title: '',
             body: ''
           }
  },

  todosChanged: function() {
    console.log("resetting state")
    this.setState({ todos: TodoStore.all() });
  },

  componentDidMount: function() {
    this.listener = TodoStore.addChangedHandler(this.todosChanged);
    TodoStore.fetch();
  },

  componentWillUnmount: function() {
    this.listener.remove();
  },

  createNewTodo: function(event) {
    event.preventDefault();

    TodoStore.create( { title: this.state.title, body: this.state.body });
    this.setState({ title: "", body: "" });
  },

  render: function() {
    var todos = this.state.todos.map(function(todo, index) {
      return (
        <TodoListItem key={ index } todo={ todo }/>
      );
    });

    return (
      <div>
        <form>
          Title: <input type="text" valueLink={this.linkState('title')}/>
        Body: <input type="text" valueLink={this.linkState('body')}/>
      <input type="submit" onClick={this.createNewTodo}></input>


        </form>

        <ul>
          { todos }
        </ul>


      </div>
    );
  }


});

module.exports = TodoList;
