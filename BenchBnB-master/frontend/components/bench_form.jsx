var React = require('react'),
    ApiUtil = require('../util/api_util'),
    BenchFormActions = require('../actions/bench_form_actions'),
    ErrorStore = require('../stores/error'),
    Error = require('./error'),
    LinkedStateMixin = require('react-addons-linked-state-mixin');

var BenchForm = React.createClass({
  mixins: [LinkedStateMixin],

  blankAttrs: {
    lat: '',
    lng: '',
    seating: '',
    description: ''
  },

  getInitialState: function () {
    return this.blankAttrs;
  },

  handleSubmit: function(event) {
    event.preventDefault();

    benchForm = {
      lat: parseInt(this.state.lat),
      lng: parseInt(this.state.lng),
      seating: parseInt(this.state.seating),
      description: this.state.description
    };

    BenchFormActions.createBench(benchForm);
    this.setState(this.blankAttrs);
  },

  render: function() {
    return (
      <div>
        <Error/>
        <form onSubmit={this.handleSubmit}>
          <label htmlFor="lat">Latitude: </label>
          <input valueLink={this.linkState('lat')}
                 type="text"
                 id="lat"
                 placeholder="Input Latitude"/><br/>

          <label htmlFor="lng">Longitude: </label>
          <input valueLink={this.linkState('lng')}
                 type="text"
                 id="lng"
                 placeholder="Input Longitude"/><br/>

          <label htmlFor="seating">Seating: </label>
          <input valueLink={this.linkState('seating')}
                  type="text"
                  id="seating"
                  placeholder="Input number of seats"/><br/>

                <label htmlFor="desc">Description: </label><br/>
          <textarea valueLink={this.linkState('description')}
                    id="desc"
                    rows="4"
                    cols="40"
                    placeholder="Enter a description"></textarea><br/>

          <input type="submit" value="Create Bench"/>
        </form>
      </div>
           );
  }

});

module.exports = BenchForm;
