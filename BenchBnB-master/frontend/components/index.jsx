var React = require('react'),
    BenchStore = require('../stores/bench'),
    HighlightedBenchStore = require('../stores/highlighted_bench_store'),
    ApiUtil = require('../util/api_util'),
    HighlightedBenchActions = require('../actions/highlighted_bench_actions');

var Index = React.createClass({
  getInitialState: function() {
    return ({ benches: BenchStore.all() });
  },

  getBenches: function() {
    this.setState({ benches: BenchStore.all() });
  },

  componentDidMount: function() {
    this.token = BenchStore.addListener(this.getBenches);
  },

  componentWillUnmount: function() {
    this.token.remove();
  },

  render: function() {
    var benches = this.state.benches;

    if (benches.length === 0) {
      return (<div></div>);
    }

    var benchList = benches.map(function(bench, index) {
      return (<div key={index} onMouseOver={HighlightedBenchActions.receiveHighlightedBench.bind(HighlightedBenchActions, bench)}>
        I'm a bench {index + 1}.</div>);
    });

    return (
          <div>
            {benchList}
          </div>
          );
  }

});

module.exports = Index;
