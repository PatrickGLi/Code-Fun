var Tile = require('./tile.js');

var Board = function(mapSize, numBombs) {
  var numBombs = typeof numBombs !== 'undefined' ?  numBombs : 10;
  var mapSize = typeof mapSize !== 'undefined' ?  mapSize : 10;
  this.nearbyPositions = [[-1, 1], [0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0]];
  this.mapSize = mapSize;
  this.numBombs = numBombs;
  this.grid = this.createGrid(this.mapSize);
  this.populateBombs(this.numBombs);
};

Board.prototype.createGrid = function(mapSize) {
  var grid = [];

  for (var i = 0; i < mapSize; i++) {
    var sub = [];
    for (var j = 0; j < mapSize; j++) {
      sub.push(new Tile("H", [i, j]));
    }

    grid.push(sub);
  }

  return grid;
};

Board.prototype.populateBombs = function(numBombs) {
  var bombCount = 0;
  while (bombCount < numBombs) {
    var randomX = Math.floor(Math.random() * 10);
    var randomY = Math.floor(Math.random() * 10);

    var tile = this.grid[randomX][randomY];

    if (!tile.hasBomb()) {
      tile.addBomb();
      bombCount ++;
    }
  }
};

Board.prototype.bombCount = function() {
  var count = 0;
  this.grid.forEach(function(arr) {
    arr.forEach(function(el) {
      if (el.hasBomb()) {
        count ++;
      }
    });
  });

  return count;
};

Board.prototype.hasBomb = function(xPos, yPos) {
  return this.grid[xPos][yPos].hasBomb();
};

Board.prototype.handleClick = function(xPos, yPos) {
  if (this.hasBomb(xPos, yPos)) {
    return;
  }

  return this.propagate(xPos, yPos);
};

Board.prototype.propagate = function(xPos, yPos) {
  var currentTile = this.grid[xPos][yPos];
  currentTile.visit();

  var queue = [currentTile];

  while (queue.length > 0) {
    var tile = queue.shift();

    var newPositions = []
    var nearbyBombs = 0;
    this.nearbyPositions.forEach(function(position) {
      var newPosition = [tile.returnCoordinates()[0] + position[0], tile.returnCoordinates()[1] + position[1]];
      if (!this.inBounds(newPosition[0], newPosition[1])) {
        return;
      }

      var nextTile = this.grid[newPosition[0]][newPosition[1]];

      if (!nextTile.hasVisited() && nextTile.showStatus !== "F") {
        newPositions.push(nextTile);
        if (nextTile.hasBomb()) {
          nearbyBombs ++;
        }
      }

    }.bind(this));

    if (nearbyBombs > 0) {
      tile.changeStatus(nearbyBombs);
    } else {
      tile.changeStatus("R");
      newPositions.forEach(function(tile) {
        tile.visit();
      });
      queue = queue.concat(newPositions);
    }
  }

  return false;
};

Board.prototype.inBounds = function(xPos, yPos) {
  var range = this.grid.length;
  return (xPos >= 0 && xPos < range && yPos >= 0 && yPos < range);
};

Board.prototype.toggleFlag = function(xPos, yPos) {
  this.grid[xPos][yPos].toggleFlag();
};

Board.prototype.winner = function() {
  var revealCount = 0;
  this.grid.forEach(function(array) {
    array.forEach(function(tile) {
      if (tile.showStatus() === "R") {
        revealCount++;
      }
    });
  });

  return revealCount + this.numBombs === this.mapSize * this.mapSize;
};

Board.prototype.reveal = function() {
  this.grid.forEach(function(array) {
    array.forEach(function(tile) {
      if (tile.hasBomb()) {
        tile.changeStatus("Bombs Shown");
      }
    });
  });

  return this.grid;
};

Board.prototype.getTile = function(xPos, yPos) {
  return this.grid[xPos][yPos].showStatus();
}
module.exports = Board;
