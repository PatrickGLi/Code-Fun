var TodoStore = {
  _todos:  [],

  _callbacks: [],

  changed: function() {
    TodoStore._callbacks.forEach(function(cb) {
      cb();
    });
  },

  addChangedHandler: function(handler) {
    TodoStore._callbacks.push(handler);
  },

  removeChangedHandler: function(callback) {
    for (var i = 0; i < TodoStore._callbacks.length; i++) {
      if (_callbacks[i] === callback){
        TodoStore._callbacks.splice(i, 1); // maybe save as var idx
        break;
      }
    }
  },

  all: function() {
    return TodoStore._todos;
  },

  fetch: function() {
    $.ajax({
      method: 'GET',
      dataType: 'json',
      url: 'api/todos',
      success: function(data) {
        console.log(data)
        TodoStore._todos = data;
        TodoStore.changed();
      }
    });
  },

  create: function(todo) {
    $.ajax({
      method: 'POST',
      dataType: 'json',
      data: { todo: todo },
      url: 'api/todos',
      success: function(response) {
        TodoStore._todos.push(response);
        TodoStore.changed();
      }
    });
  },

  find: function(id) {
    this._todos.find(function(todoItem) {
      return todoItem.id === id;
    });

    return null;
  },

  destroy: function(id) {
    if (this.find(id)) {
      $.ajax({
        method: 'DELETE',
        dataType: 'json',
        url: 'api/todos/' + id,
        success: function(response) {
          TodoStore._todos = data;
          TodoStore.changed();
        }
      });
    }
  },

  toggleDone: function(id) {
      var that = this;
      var todo = TodoStore._todos[this.find(id)];
      var done = !todo.done;

      if (todo) {
        $.ajax({
          method: 'PATCH',
          url: 'api/todos/' + id,
          data: { todo: {done: done}},
          success: function() {
            todo.done = done;
            that.changed();
          }
        });
      }
    }
};


module.exports = TodoStore;
