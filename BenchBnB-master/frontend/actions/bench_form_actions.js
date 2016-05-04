var BenchConstants = require('../constants/bench_constants'),
    Dispatcher = require('../dispatcher/dispatcher'),
    ApiUtil = require('../util/api_util');

var BenchFormActions = {
  createBench: function(data) {
    ApiUtil.createBench(data);
    // Dispatcher sets flag boolean to notify loading
  }
};

module.exports = BenchFormActions;
