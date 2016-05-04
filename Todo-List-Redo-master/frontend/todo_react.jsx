var TodoList = require('./components/todo_list'),
    React = require('react'),
    ReactDOM = require('react-dom');


    $(function() {
      var root = document.getElementById('root');

      if (root) {
        ReactDOM.render(<TodoList/>, root);
      }
    });
