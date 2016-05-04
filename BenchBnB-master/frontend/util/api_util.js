var ApiActions = require('../actions/api_actions');

var ApiUtil = {

  fetchBenches: function(bounds) {
    $.getJSON('api/benches', {bounds: bounds}, function(benchData) {
      ApiActions.receiveAll(benchData);
    });
  },

  createBench: function(bench) {
    $.ajax({
      method: "post",
      url: "api/benches",
      data: {bench: bench},
      success: function (successData) {
        debugger
      },
      error: function(errorData) {
        ApiActions.formError(errorData);
      }

    });
  }

};

module.exports = ApiUtil;
