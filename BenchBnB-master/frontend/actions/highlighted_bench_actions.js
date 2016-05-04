var BenchConstants = require('../constants/bench_constants'),
    Dispatcher = require('../dispatcher/dispatcher');

var HighlightedBenchActions = {
  receiveHighlightedBench: function(bench) {
    Dispatcher.dispatch({
      actionType: BenchConstants.HIGHLIGHTED_BENCH_RECEIVED,
      bench: bench
    });
  }

};

module.exports = HighlightedBenchActions;
