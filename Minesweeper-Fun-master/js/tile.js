var Tile = function(initial, coordinates) {
  this.visited = false;
  this.status = initial;
  this.coordinates = coordinates;
  this.flag = false;
  this.bomb = null;
};

Tile.prototype.returnCoordinates = function() {
  return this.coordinates;
};

Tile.prototype.hasBomb = function() {
  return this.bomb === "B";
};

Tile.prototype.addBomb = function() {
  this.bomb = "B";
  return this.bomb;
};

Tile.prototype.showStatus = function() {
  return this.status;
};

Tile.prototype.toggleFlag = function() {
  return this.flag = this.flag ? true : false;
}

Tile.prototype.changeStatus = function(newStatus) {
  this.status = newStatus;
  return this.status;
};

Tile.prototype.hasVisited = function() {
  return this.visited;
};

Tile.prototype.visit = function() {
  return this.visited = true;
}

module.exports = Tile;
