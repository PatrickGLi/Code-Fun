
var Board = require('./board.js');


var Game = function() {
  this.board = new Board();
};

Game.prototype.leftClick = function(xPos, yPos) {
    this.board.handleClick(xPos, yPos);

    if (this.board.hasBomb(xPos, yPos) || this.board.winner()) {
      this.gameOver();
    }

    console.log(this.board.grid);
};

Game.prototype.play = function() {
  while (!this.gameOver()) {
    this.leftClick();
  }

  console.log("you win!");
};

Game.prototype.gameOver = function() {
  this.board.reveal();
};

Game.prototype.rightClick = function() {
  this.board.toggleFlag(xPos, yPos);
};

Game.prototype.returnValue = function(xPos, yPos) {
  return this.board.getTile(xPos, yPos);
};
module.exports = Game;
