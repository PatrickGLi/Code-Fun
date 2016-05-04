function GameView (game, content) {
  this.game = game;
  this.content = content;
  this.createBoard();
  this.addListeners();
};

GameView.prototype.createBoard = function() {
  for (var i = 0; i < 10; i++) {
    var row = $("<div class='row'>");
    for (var j = 0; j < 10; j++) {
      row.append("<div class='" + i + "-" + j + "'></div>");
    }

    this.content.append(row);
  }
};

GameView.prototype.addListeners = function() {
  this.content.on('click', function(el) {
    var coordinates = this.parseId(el.target.className);

    this.game.leftClick(coordinates[0], coordinates[1]);

    this.refreshBoard();
  }.bind(this));
};

GameView.prototype.refreshBoard = function() {
  for (var i = 0; i < 10; i++) {
    for (var j = 0; j < 10; j++) {
      switch (this.game.returnValue(i, j)) {
          case "H":
            break;
          case "R":
          console.log(this.element(i, j));
            this.element(i, j).addClass("revealed");
            break;
          case "Bombs Shown":
            this.element(i, j).addClass("bombs-revealed");
            break;
          default:
            this.element(i, j).text(this.game.returnValue(i, j));
      }
    }
  }
};

GameView.prototype.element = function(i, j) {
  return $('.' + i + '-' + j);
}

GameView.prototype.parseId = function(className){
  return className.split('-').map(function(stringNum) { return parseInt(stringNum); });
};

module.exports = GameView;
