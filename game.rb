class Game
  attr_reader :coordinates

  def initialize(coordinates = [])
    @coordinates = coordinates
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

