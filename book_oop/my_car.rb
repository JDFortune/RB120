class MyCar
  attr_accessor :speed, :car_status, :model, :color
  attr_reader :year

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
    @car_status = 'off'
  end

  def speed_up(num)
    if @car_status == 'off'
      puts "Can't speed up while car is turned off."
    else
      @speed += num
    end
    p "You press the gas and accelerate #{num} mph."
  end

  def brake(num)
    @speed -= (num)
    p "Car decelerates #{num} mph"
  end

  def start
    p "car already on" unless @car_status == 'off'
    self.car_status = 'on' unless car_status == 'on'
    p "Car is on"
  end

  def shut_off
    if @speed > 0
      p "Can't shut off car while moving"
    else
      if @car_status == 'on'
        self.car_status = 'off'
        p "Car is off"
      end
    end
  end
  
  def spray_paint(color)
    self.color = color
    p "Your new #{color} paint job looks great!"
  end

end

ruby = MyCar.new(2018, 'Ruby', 'CX-5')


