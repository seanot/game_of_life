require 'rspec'
require_relative 'game'


describe Game do
  context '#initialize' do
    it 'allows initialization with no coordinates' do
      game = Game.new
      expect(game).to be_a Game
      expect(game.coordinates).to eq []
    end

    it 'allows initialization with coordinates' do
      coordinates = [[0,1], [1,1], [2,1]]
      game = Game.new coordinates
      expect(game).to be_a Game
      expect(game.coordinates).to eq coordinates
    end

    it 'allows initialization with universe' do
      universe = Array.new(10) { Array.new(10) }
      game = Game.new universe
      expect(game).to be_a Game
      expect(game.universe).to eq universe
    end
  end

  context '#has_coordinate?' do
    it 'does not find a coordinate' do
      game = Game.new
      expect(game.has_coordinate?([1,1])).to eq false
    end

    it 'finds a coordinate' do
      game = Game.new [[1,1]]
      expect(game.has_coordinate?([1,1])).to eq true
    end
  end

  context '#live_neighbors_above' do
    it 'finds no live neighbors above' do
      game = Game.new
      expect(game.live_neighbors_above([1,1])).to eq 0
    end

    it 'finds zero live neighbors above' do
      game = Game.new([[2,2], [2,3]])
      expect(game.live_neighbors_above([2,2])).to eq 0
    end

    it 'finds one live neighbor above' do
      game = Game.new([[1,1], [2,2]])
      expect(game.live_neighbors_above([2,2])).to eq 1
    end

    it 'finds three live neighbors above' do
      game = Game.new([[1,1], [1,2], [1,3], [2,2]])
      expect(game.live_neighbors_above([2,2])).to eq 3
    end
  end

  context '#live_neighbors_astride' do
    it 'finds no live neighbors astride' do
      game = Game.new
      expect(game.live_neighbors_astride([2,2])).to eq 0
    end

    it 'finds zero live neighbors astride' do
      game = Game.new([[2,2], [3,3]])
      expect(game.live_neighbors_astride([2,2])).to eq 0
    end

    it 'finds two live live_neighbors_astride' do
      game = Game.new([[2,1], [2,2], [2,3]])
      expect(game.live_neighbors_astride([2,2])). to eq 2
    end
  end

  context '#live_neighbors_below' do
    it 'finds no live neighbors below' do
      game = Game.new
      expect(game.live_neighbors_below([1,1])).to eq 0
    end

    it 'finds zero live neighbors below' do
      game = Game.new([[1,1], [2,2]])
      expect(game.live_neighbors_below([2,2])).to eq 0
    end

    it 'finds one live neighbor below' do
      game = Game.new([[3,1], [2,2]])
      expect(game.live_neighbors_below([2,2])).to eq 1
    end

    it 'finds three live neighbors below' do
      game = Game.new([[3,1], [3,2], [3,3], [2,2]])
      expect(game.live_neighbors_below([2,2])).to eq 3
    end
  end

  context '#live_neighbors' do
    it 'finds no live neighbors' do
      game = Game.new
      expect(game.live_neighbors([1,1])).to eq 0
    end

    it 'finds three live neighbors' do
      game = Game.new([[1,1], [2,2], [2,3], [3,3]])
      expect(game.live_neighbors([2,2])).to eq 3
    end
  end

  context '#live_cells' do
    it 'reports the correct number of live cells' do
      game = Game.new([[0,0], [0,1]])
      expect(game.live_cells).to eq 2
    end
  end

  context '#die?' do
    it 'dies if less than 2 neighbors' do
      game = Game.new
      expect(game.die?(1)).to eq true
    end

    it 'dies if more than 3 neighbors' do
      game = Game.new
      expect(game.die?(4)).to eq true
    end

    it 'stays alive if has 2 neighbors' do
      game = Game.new
      expect(game.die?(2)).to eq false
    end

    it 'stays alive if has 3 neighbors' do
      game = Game.new
      expect(game.die?(3)).to eq false
    end

    it 'does not die' do
      game = Game.new([[1,1], [1,2], [2,2]])
      expect(game.die?(game.live_neighbors([2,2]))).to eq false
    end

    it 'dies because of too few neighbors' do
      game = Game.new([[1,2], [2,2]])
      expect(game.die?(game.live_neighbors([2,2]))).to eq true
    end

    it 'dies because of too many neighbors' do
      game = Game.new([[1,1], [1,2], [2,2], [2,1], [2,3]])
      expect(game.die?(game.live_neighbors([2,2]))).to eq true
    end
  end

  context '#all_cells' do
    it 'creates the correct number of cells' do
      game = Game.new([], 10)
      expect(game.all_cells.length).to eq 100
    end
  end

  context '#dead_cells' do
    it 'includes dead cells' do
      game = Game.new([], 10)
      expect(game.dead_cells).to include([9,9])
    end

    it 'does not include live cells' do
      game = Game.new([[0,0]], 10)
      expect(game.dead_cells).to_not include([0,0])
    end
  end

  context '#births' do
    it 'is born if it has exactly three live neighbors' do
      game = Game.new([[0,0], [0,1], [0,2]])
      expect(game.births.length).to eq 1
    end

    it 'is not born if it has exactly two live neighbors' do
      game = Game.new([[0,0], [0,1]])
      expect(game.births.length).to eq 0
    end

    it 'is not born if it has exactly four live neighbors' do
      game = Game.new([[0,0], [0,1], [0,2], [1,0]])
      expect(game.births.length).to eq 0
    end

    it 'has exactly two births' do
      game = Game.new([[0,0], [0,1], [0,2], [3,1], [3,2], [3,3]], 4)
      expect(game.births).to eq([[1,1], [2,2]])
    end
  end
end
