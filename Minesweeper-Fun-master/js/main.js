var Game = require('./game.js'),
    GameView = require('./gameView.js');

$(function() {
  var content = $('#content');
  var game = new Game();
  var gameView = new GameView(game, content);
});
