var React = require('react'),
    ReactDOM = require('react-dom'),
    BenchStore = require('./stores/bench'),
    ApiUtil = require('./util/api_util'),
    ReactRouter = require('react-router'),
    Router = ReactRouter.Router,
    Route = ReactRouter.Route,
    IndexRoute = ReactRouter.IndexRoute,
    Search = require('./components/search'),
    BenchForm = require('./components/bench_form');

var App = React.createClass({
  render: function(){
    return (
        <div>
          <header><h1>Bench BnB</h1></header>
          {this.props.children}
        </div>
    );
  }
});

var routes = (
  <Router>
    <Route path="/" component={App}>
      <IndexRoute component={Search}/>
      <Route path="benches/new" component={BenchForm}>
      </Route>
    </Route>
  </Router>
);

$(function() {
  ReactDOM.render(routes , document.getElementById('content'));
});
