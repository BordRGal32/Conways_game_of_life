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
        new_grid.population[[i+1,j+1]] = Cell.new
      end
    end
    new_grid
  end

  def live_neighbors(x,y)
    counter = 0
    (x-1).upto(x+1) do |loop_x|
      (y-1).upto(y+1) do |loop_y|

        if @population[wrap_universe(loop_x,loop_y)].state == true
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

  def wrap_universe(x,y)
    new_coord = [x,y]
    if x == 0
      new_coord[0] =  @width
    end
    if y == 0
      new_coord[1] = @height
    end
    if x == @width + 1
      new_coord[0] = 1
    end
    if y == @height + 1
      new_coord[1] = 1
    end
    new_coord
  end
end


