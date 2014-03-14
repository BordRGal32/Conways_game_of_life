require 'rspec'
require 'cell'

describe Cell do
  describe 'initialize' do
    it 'makes an instance of the Cell class' do
      new_cell = Cell.new
      new_cell.should be_an_instance_of Cell
      new_cell.state.should eq false
    end
  end


end
