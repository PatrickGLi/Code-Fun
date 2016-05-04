var React = require('react'),
    Map = require('./map'),
    Index = require('./index');

var Search = React.createClass({

  render: function() {
    return (
            <div>
              <Map/>
              <Index/>
            </div>
           );
  }
});

module.exports = Search;
