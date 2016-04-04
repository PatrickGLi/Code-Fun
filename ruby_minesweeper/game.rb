require_relative 'board.rb'

class Game
  attr_reader :board

  def initialize
    @board = Board.setup_standard_board
  end

end

game = Game.new
game.board.explore([0, 0])

p game.board
