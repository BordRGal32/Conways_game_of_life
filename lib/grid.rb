# require './cell'
class Grid
  attr_reader :width, :height, :population

  def initialize(width, height)
    @population = {}
    @width = width
    @height = height
  end

  def clear
    @population = {}
  end

  def Grid.create(width, height)
    new_grid = Grid.new(width, height)
    width.times do |i|
      height.times do |j|
        new_grid.population[[i,j]] = Cell.new
      end
    end
    new_grid
  end

  def live_neighbors(x,y)
    counter = 0
    (x-1).upto(x+1) do |loop_x|
      (y-1).upto(y+1) do |loop_y|

        if @population[[loop_x,loop_y]].state == true
          counter +=1
        end
      end
    end
    if @population[[x,y]].state == true
      counter -= 1
    end
    counter
  end

  def set_future_state(x,y)
    this_cell = @population[[x,y]]
    state_counter = self.live_neighbors(x,y)
    if state_counter > 1 && state_counter < 4 && this_cell.state == true
      this_cell.future_state = true
    elsif(state_counter < 2 && this_cell.state = true)
      this_cell.future_state = false
    elsif state_counter > 3 && this_cell.state == true
      this_cell.future_state = false
    elsif state_counter > 2 && this_cell.state == false
      this_cell.future_state = true
    end
  end
end

# puts new_grid = Grid.create(10,10)
# new_grid.population[[1,2]].state = true
# new_grid.population[[2,1]].state = true
# new_grid.population[[2,3]].state = true
# new_grid.population[[3,2]].state = true

# new_grid.set_future_state(2,2)

