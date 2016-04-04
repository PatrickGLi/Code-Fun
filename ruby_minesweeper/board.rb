require_relative 'tile.rb'
require 'byebug'

class Board
  attr_reader :grid, :lost

  def self.setup_standard_board
    Board.new(10, 99)
  end

  def initialize(size, num_bombs)
    @grid_size = size
    @grid = self.create_grid
    @num_bombs = num_bombs
    @lost = false

    self.populate_bombs
  end

  def toggle_flag(location)
    result = location.split(",")
    @grid[result[0].to_i][result[1].to_i].toggle_flag
  end

  def render
    @grid.each do |row|
      p row
    end
  end

  def won?
    unvisited = 0

    @grid.each do |row|
      row.each do |element|
        unvisited += 1 unless element.visited?
      end
    end

    unvisited == @num_bombs
  end

  def reveal
    @grid.each do |row|
      line = []
      row.each do |element|
        if element.bombed?
          line << "B"
        elsif element.neighbor_bomb_count > 0
          line << "#{element.neighbor_bomb_count}"
        else
          line << "_"
        end
      end

      p line
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
    result = location.split(",")

    first_tile = @grid[result[0].to_i][result[1].to_i]
    queue = [first_tile]

    until queue.empty?
      current_tile = queue.shift

      unless current_tile.flagged?
        exploration_result = current_tile.explore_tile
        if exploration_result.zero?
          current_tile.neighbors.each do |neighbor|
            queue << neighbor unless neighbor.visited?
          end
        elsif exploration_result == -1
          @lost = true
          return
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
