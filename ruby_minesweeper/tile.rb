class Tile
  NEIGHBORS = [[1, 0], [1, 1], [0, 1], [-1, 1], [0, -1], [-1, -1], [0, -1], [1, -1]]

  def initialize(board, location)
    @board = board
    @location = location
    @visited = false
    @bombed = false
    @flagged = false
  end

  def inspect
    @visited ? "#{@visited}" : "*"
  end

  def flag
    @flagged = true
  end

  def visited?
    @visited
  end

  def flagged?
    @flagged
  end

  def bombed?
    @bombed
  end

  def add_bomb
    @bombed = true
  end

  def neighbor_bomb_count
    bomb_count = 0

    NEIGHBORS.each do |x_coord, y_coord|
      neighbor_coordinates = [@location[0] + x_coord, @location[1] + y_coord]
      if @board.in_bounds?(neighbor_coordinates)
        bomb_count += 1 if @board.grid[neighbor_coordinates[0]][neighbor_coordinates[1]].bombed?
      end
    end

    bomb_count
  end

  def neighbors
    neighbors = []
    NEIGHBORS.each do |x_coord, y_coord|
      neighbor_coordinates = [@location[0] + x_coord, @location[1] + y_coord]

      if @board.in_bounds?(neighbor_coordinates)
        neighbors << @board.grid[neighbor_coordinates[0]][neighbor_coordinates[1]]
      end
    end

    neighbors
  end

  def explore_tile
    bomb_count = neighbor_bomb_count
    @visited = bomb_count > 0 ? bomb_count : "_"
    bomb_count
  end




end
