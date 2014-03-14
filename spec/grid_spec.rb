require 'rspec'
require 'grid'
require 'cell'

describe Grid do
  # before do
  #   Grid.clear
  # end

  describe 'initialize' do
    it 'makes an instance of the Grid class' do
      new_grid = Grid.new(20, 20)
      new_grid.should be_an_instance_of Grid
    end
    it 'sets the height and width' do
      new_grid = Grid.new(20, 20)
      new_grid.width.should eq 20
    end
  end

  describe '.create' do
    it 'should create a new instance of the grid class' do
      new_grid = Grid.create(20,20)
      new_grid.should be_an_instance_of Grid
    end
    it 'fills the population hash with cells where each cells key is an array with its coordinates' do
      new_grid = Grid.create(20,20)
      new_grid.population[[3,4]].should be_an_instance_of Cell

    end
  end

  describe '#live_neighbors' do
    it 'finds out how many neighbors are alive around a given cell' do
      new_grid = Grid.create(20,20)
      new_grid.population[[1,2]].state = true
      new_grid.population[[2,1]].state = true
      new_grid.population[[2,3]].state = true
      new_grid.population[[3,2]].state = true
      new_grid.live_neighbors(2,2).should eq 4
    end
    it 'finds out how many neighbors are alive and accounts for a wrapped universe' do
      new_grid = Grid.create(5,5)
      new_grid.population[[1,5]].state = true
      new_grid.live_neighbors(5,5).should eq 1
    end
    it 'finds out how many neighbors are alive and accounts for a wrapped universe' do
      new_grid = Grid.create(5,5)
      new_grid.population[[5,4]].state = true
      new_grid.live_neighbors(1,4).should eq 1
    end
  end

  describe 'set_future_state' do
    it 'sets the future state to true if the current cell is alive and has 2 or 3 neighbors' do
      new_grid = Grid.create(20,20)
      new_grid.population[[2,2]].state = true
      new_grid.population[[3,3]].state = true
      new_grid.population[[2,3]].state = true
      new_grid.population[[3,1]].state = true
      new_grid.set_future_state(2,2)
      new_grid.population[[2,2]].future_state.should eq true
    end
    it 'sets the future state of a live cell with less than two live neighbors to false aka that cell dies' do
      new_grid = Grid.create(20,20)
      new_grid.population[[2,2]].state = true
      new_grid.population[[3,3]].state = true
      new_grid.set_future_state(2,2)
      new_grid.population[[2,2]].future_state.should eq false
    end
    it 'set the future state to false if the cell is alive and has more than three live neighbors' do
      new_grid = Grid.create(20,20)
      new_grid.population[[2,2]].future_state = true
      new_grid.population[[2,2]].state = true
      new_grid.population[[1,2]].state = true
      new_grid.population[[2,1]].state = true
      new_grid.population[[2,3]].state = true
      new_grid.population[[3,2]].state = true

      new_grid.set_future_state(2,2)
      new_grid.population[[2,2]].future_state.should eq false
    end
    it 'sets the future state to true if a dead cell is surrounded by 3 or more live neighbors' do
      new_grid = Grid.create(20,20)
      new_grid.population[[1,2]].state = true
      new_grid.population[[2,1]].state = true
      new_grid.population[[2,3]].state = true
      new_grid.population[[3,2]].state = true

      new_grid.set_future_state(2,2)
      new_grid.population[[2,2]].future_state.should eq true
    end
  end

  describe 'wrap_universe' do
    it 'translates negative coordinates to coordinates on the opposite side of the grid' do
      new_grid = Grid.create(5,5)
      new_grid.wrap_universe(1,0).should eq [1,5]
    end
    it 'translates negative coordinates to coordinates on the opposite side of the grid' do
      new_grid = Grid.create(5,5)
      new_grid.wrap_universe(0,1).should eq [5,1]
    end
    it 'translates too large coordinates to 1' do
      new_grid = Grid.create(5,5)
      new_grid.wrap_universe(1,6).should eq [1,1]
    end
    it 'translates too large coordinates to 1' do
      new_grid = Grid.create(5,5)
      new_grid.wrap_universe(6,1).should eq [1,1]
    end
    it 'leaves normal coordinates the same' do
      new_grid = Grid.create(5,5)
      new_grid.wrap_universe(4,3).should eq [4,3]
    end
  end
end




