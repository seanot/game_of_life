class Game
  attr_reader :coordinates, :universe

  def initialize(coordinates = [], array_size = 10)
    @coordinates = coordinates
    @universe = Array.new(array_size) { Array.new(array_size) }
  end

  def all_cells
    all_cells = []
    universe.each_with_index do |row, row_index|
      row.each_with_index do |column, column_index|
        cell = [row_index, column_index]
        all_cells << cell
      end
    end
    all_cells
  end

  def dead_cells
    all_cells - coordinates
  end

  def die?(neighbors)
    neighbors < 2 || neighbors > 3 ? true : false
  end

  def live_cells
    coordinates.count
  end

  def live_neighbors(cell)
    live_neighbors_above(cell) +
    live_neighbors_astride(cell) +
    live_neighbors_below(cell)
  end

  def has_coordinate?(cell)
    coordinates.include?(cell) ? true : false
  end

  def live_neighbors_above(cell)
    left = has_coordinate?([cell[0]-1, cell[1]-1]) ? 1 : 0
    center = has_coordinate?([cell[0]-1, cell[1]]) ? 1 : 0
    right = has_coordinate?([cell[0]-1, cell[1]+1]) ? 1 : 0
    left+center+right
  end

  def live_neighbors_astride(cell)
    left = has_coordinate?([cell[0], cell[1]-1]) ? 1 : 0
    right = has_coordinate?([cell[0], cell[1]+1]) ? 1 : 0
    left+right
  end

  def live_neighbors_below(cell)
    left = has_coordinate?([cell[0]+1, cell[1]-1]) ? 1 : 0
    center = has_coordinate?([cell[0]+1, cell[1]]) ? 1 : 0
    right = has_coordinate?([cell[0]+1, cell[1]+1]) ? 1 : 0
    left+center+right
  end
end

# game = Game.new([[1,1],[2,2],[3,3]], 5)
# p game.dead_cells