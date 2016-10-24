require 'minitest/autorun'
require_relative 'game'

class GameTest < MiniTest::Unit::TestCase
  def test_neighbors
    assert_equal [[0, 3], [1, 3], [2, 3],
                  [0, 2],         [2, 2],
                  [0, 1], [1, 1], [2, 1]], neighbors([1,2])
  end

  def test_live_neighbors
    live_cells = []
    assert_equal [], live_neighbors([1,2],live_cells)

    live_cells = [[0, 3], [1, 3], [2, 3], [1, 2]]
    assert_equal [[0, 3], [1, 3], [2, 3]], live_neighbors([1,2],live_cells)

    live_cells = [[0, 3], [1, 3], [2, 3],
                  [0, 2], [1, 2], [2, 2],
                  [0, 1], [1, 1], [2, 1]]
    assert_equal neighbors([1,2]), live_neighbors([1,2],live_cells)
  end

  def test_dead_neighbors
    live_cells = [[0, 3], [1, 3], [2, 3], [1, 2]]
    assert_equal [[0, 2], [2, 2], [0, 1], [1, 1], [2, 1]], dead_neighbors([1,2],live_cells)

    live_cells = [[0, 3], [1, 3], [2, 3],
                  [0, 2], [1, 2], [2, 2],
                  [0, 1], [1, 1], [2, 1]]
    assert_equal [], dead_neighbors([1,2],live_cells)
   end


  def test_will_live_on
    refute will_live_on?([1,2],[])
    refute will_live_on?([1,2],[[0,3]])
    assert will_live_on?([1,2],[[0,3],[2,1]])
    assert will_live_on?([1,2],[[0,3],[2,1],[1,1]])
    refute will_live_on?([1,2],[[0,3],[2,1],[1,1],[0,1]])
  end

  def test_will_be_born
    refute will_be_born?([1,2],[[0,3],[2,1],[1,1],[0,1]])
    assert will_be_born?([1,2],[[0,3],[2,1],[1,1]])
    refute will_be_born?([1,2],[[0,3],[2,1]])

    live_cells = [[0,3],[1,2],[0,1],[1,1],[2,1]]
    assert will_be_born?([1,0],live_cells)
  end

  def test_tick
    game = new_game([[5,5],[5,6],[5,7]])
    game.tick
    assert_equal [[5, 6], [4, 6], [6, 6]], game.live_cells.to_a
    assert_equal 1, game.generation
  end

  def will_be_born?(cell, seed)
    game(:will_be_born?,cell,seed)
  end

  def will_live_on?(cell, seed)
    game(:will_live_on?,cell,seed)
  end

  def neighbors(cell)
    game(:neighbors,cell,[])
  end

  def live_neighbors(cell, seed)
    game(:live_neighbors,cell,seed)
  end

  def dead_neighbors(cell, seed)
    game(:dead_neighbors,cell,seed)
  end

  def new_game(seed)
    Game.new(20,20,seed)
  end

  def game(method,cell,seed)
    new_game(seed).send(method,cell)
  end

end
