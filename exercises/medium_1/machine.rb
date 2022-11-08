class Machine

  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end

  def to_s
    "The current state is #{switch}."
  end

  private
  attr_accessor :switch

  def flip_switch(state)
    self.switch = state
  end
end

one = Machine.new
one.start
puts one
one.stop
puts one
