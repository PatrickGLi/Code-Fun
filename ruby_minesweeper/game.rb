require_relative 'board.rb'

class Game
  attr_reader :board

  def initialize
    @board = Board.setup_standard_board
  end

  def play
    # debugger
    until board.won? || board.lost
      print "\e[2J\e[f"
      @board.render
      play_turn
    end

    @board.reveal

    puts board.won? ? "you win!" : "you lose!"
  end

  def play_turn
    puts "F or P"

    flag_or_play = gets.chomp.upcase

    puts "location?"

    location = gets.chomp

    case flag_or_play
    when "F"
      @board.toggle_flag(location)
    when "P"
      @board.explore(location)
    end
  end

end

game = Game.new

game.play
