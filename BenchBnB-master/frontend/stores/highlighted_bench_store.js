var Dispatcher = require('../dispatcher/dispatcher'),
    Store = require('flux/utils').Store,
    BenchConstants = require('../constants/bench_constants');

var _highlighted_bench = null;

var HighlightedBenchStore = new Store(Dispatcher);

HighlightedBenchStore.fetch = function() {
  return _highlighted_bench;
};

HighlightedBenchStore.__onDispatch = function(payload) {
  switch (payload.actionType) {
    case BenchConstants.HIGHLIGHTED_BENCH_RECEIVED:
      resetHighlightedBench(payload.bench);
    break;
  }
};

function resetHighlightedBench(bench) {
  _highlighted_bench = bench;
  HighlightedBenchStore.__emitChange();
}

module.exports = HighlightedBenchStore;
