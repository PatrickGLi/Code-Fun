var Dispatcher = require('../dispatcher/dispatcher'),
    Store = require('flux/utils').Store,
    BenchConstants = require('../constants/bench_constants');

var _benches = [];

var BenchStore = new Store(Dispatcher);

BenchStore.all = function() {
  return _benches.slice();
};

BenchStore.__onDispatch = function(payload) {
  switch (payload.actionType) {
    case BenchConstants.BENCHES_RECEIVED:
      resetBenches(payload.benches);
      break;
  }
};

function resetBenches (benches) {
  _benches = benches;
  BenchStore.__emitChange();
}

module.exports = BenchStore;
