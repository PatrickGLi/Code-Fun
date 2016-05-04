var React = require('react'),
    ReactDOM = require('react-dom'),
    BenchStore = require('../stores/bench'),
    ApiUtil = require('../util/api_util'),
    HighlightedBenchStore = require('../stores/highlighted_bench_store');

var Map = React.createClass({

  componentDidMount: function(){
     var map = ReactDOM.findDOMNode(this.refs.map);
     var mapOptions = {
       center: {lat: 37.7758, lng: -122.435},
       zoom: 13
     };
     this.map = new google.maps.Map(map, mapOptions);

     BenchStore.addListener(this.change);
     HighlightedBenchStore.addListener(this.highlight);

     var that = this;
     this.map.addListener('idle', function(e) {
       var bounds = that.map.getBounds(),
           northEastBound = bounds.getNorthEast(),
           southWestBound = bounds.getSouthWest();

      var bounds = {
        northBound: northEastBound.lng(),
        eastBound: northEastBound.lat(),
        southBound: southWestBound.lng(),
        westBound: southWestBound.lat()
      };

       ApiUtil.fetchBenches(bounds);
      });
   },

   highlight: function() {
     var highlightedBenchId = HighlightedBenchStore.fetch().id;

     if (typeof this.markers[highlightedBenchId] !== 'undefined') {
       this.markers[highlightedBenchId].setAnimation(google.maps.Animation.BOUNCE);
     }
   },

  change: function() {
    this.benchIds = this.benchIds || [];
    this.markers = this.markers || {};

    var newBenches = BenchStore.all();
    var newBenchIds = newBenches.map(function(bench) {
      return bench.id;
    });

    for (var i = 0; i < newBenchIds.length; i++) {
      if (this.benchIds.indexOf(newBenchIds[i]) !== -1) {
        continue;
      }

      var myLatLng = {lat: newBenches[i].lat, lng: newBenches[i].lng};

      var marker = new google.maps.Marker({
        position: myLatLng,
        map: this.map,
        animation: null
      });

      function toggleBounce(marker) {
        if (marker.getAnimation() !== null) {
          marker.setAnimation(null);
        } else {
          marker.setAnimation(google.maps.Animation.BOUNCE);
        }
      }

      marker.addListener('click', toggleBounce.bind(null, marker));

      var id = newBenchIds[i].toString();

      this.markers[id] = marker;
      this.benchIds.push(newBenchIds[i]);
    }

    var benchesToRemoveId = this.benchIds.filter(function (benchId) {
      return (newBenchIds.indexOf(benchId) === -1);
    });

    this.benchIds = newBenchIds;

    var that = this;
    benchesToRemoveId.forEach(function(benchToRemoveId) {
      var markerKey = benchToRemoveId.toString();
      that.markers[markerKey].setMap(null);
      delete that.markers[markerKey];
    });

  },

  render: function() {
    return (
            <div className="map" ref="map">

            </div>
           );
  }


});

module.exports = Map;
