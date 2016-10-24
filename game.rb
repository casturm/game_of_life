require 'set'

class Game
  attr_reader :generation
  attr_reader :live_cells

  def initialize(rows, cols, seed)
    @live_cells = Set.new(seed)
    @generation = 0
  end

  def tick
    @live_cells = next_generation
    @generation = @generation + 1
  end

  def next_generation
    new_generation = Set.new
    dead_cells = Set.new

    @live_cells.each do |live_cell|
      new_generation << live_cell if will_live_on?(live_cell)
      dead_cells.merge(dead_neighbors(live_cell))
    end

    dead_cells.each do |dead_cell|
      new_generation << dead_cell if will_be_born?(dead_cell)
    end
    new_generation
  end

  def neighbors(cell)
    x = cell[0]
    y = cell[1]

    [[x-1, y+1],
     [x, y+1],
     [x+1, y+1],
     [x-1, y],
     [x+1, y],
     [x-1, y-1],
     [x, y-1],
     [x+1, y-1]]
  end

  def will_live_on?(live_cell)
    live_neighbors_count = live_neighbors(live_cell).count
    live_neighbors_count == 2 || live_neighbors_count == 3
  end

  def will_be_born?(dead_cell)
    live_neighbors(dead_cell).count == 3
  end

  def live_neighbors(cell)
    neighbors(cell).select do |neighbor|
      @live_cells.include?(neighbor)
    end
  end

  def dead_neighbors(live_cell)
    neighbors(live_cell).reject do |neighbor|
      @live_cells.include?(neighbor)
    end
  end
end
