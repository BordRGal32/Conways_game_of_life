class Cell
  attr_accessor :state, :future_state

  def initialize
    @state = false
    @future_state = false
  end
end
