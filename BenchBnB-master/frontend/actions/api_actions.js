var BenchConstants = require('../constants/bench_constants'),
    Dispatcher = require('../dispatcher/dispatcher');

var ApiActions = {
  receiveAll: function(benches) {
    Dispatcher.dispatch({
      actionType: BenchConstants.BENCHES_RECEIVED,
      benches: benches
    });
  },

  formError: function(errorData) {
    Dispatcher.dispatch({
      actionType: "FORM_ERROR",
      errorData: errorData
    });
  }

};

module.exports = ApiActions;
