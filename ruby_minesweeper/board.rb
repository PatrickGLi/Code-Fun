require_relative 'tile.rb'
require 'byebug'

class Board
  attr_reader :grid

  def self.setup_standard_board
    Board.new(10, 10)
  end

  def initialize(size, num_bombs)
    @grid_size = size
    @grid = self.create_grid
    @num_bombs = num_bombs

    self.populate_bombs
  end

  def inspect
    @grid.each do |row|
      row
    end
  end

  def create_grid
    grid = []

    (0...@grid_size).each do |x|
      row = []
      (0...@grid_size).each do |y|
        row << Tile.new(self, [x, y])
      end

      grid << row
    end

    grid
  end

  def populate_bombs
    bombs_unpopulated = @num_bombs

    until bombs_unpopulated.zero?
      x = rand(0...@grid_size)
      y = rand(0...@grid_size)

      unless @grid[x][y].bombed?
        @grid[x][y].add_bomb
        bombs_unpopulated -= 1
      end
    end
  end

  def explore(location)
    first_tile = @grid[location[0]][location[1]]
    queue = [first_tile]

    until queue.empty?
      current_tile = queue.shift

      unless current_tile.flagged?
        if current_tile.explore_tile.zero?
          current_tile.neighbors.each do |neighbor|
            queue << neighbor unless neighbor.visited?
          end
        end
      end
    end

    @grid
  end

  def in_bounds?(location)
    location[0].between?(0, @grid_size - 1) &&
    location[1].between?(0, @grid_size - 1)
  end
end
