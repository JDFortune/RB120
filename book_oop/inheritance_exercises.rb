# module Loadable
#   def load
#     puts "Loaded up with cargo"
#   end
# end

# class Vehicle
#   attr_accessor :color, :speed, :car_status
#   attr_reader :model, :year

#   @@number_of_vehicles = 0

#   def initialize(color, model, year)
#     @color = color
#     @model = model
#     @year = year
#     @speed = 0
#     @car_status = 'off'
#     @@number_of_vehicles += 1
#   end

#   def self.num_vehicles
#     @@number_of_vehicles
#   end

#   def speed_up(num)
#     if @car_status == 'off'
#       puts "Can't speed up while car is turned off."
#     else
#       @speed += num
#       puts "You press the gas and accelerate #{num} mph."
#     end
#   end

#   def brake(num)
#     @speed -= (num)
#     p "Car decelerates #{num} mph"
#   end

#   def start
#     p "car already on" unless @car_status == 'off'
#     self.car_status = 'on' unless car_status == 'on'
#     p "Car is on"
#   end

#   def shut_off
#     if @speed > 0
#       p "Can't shut off car while moving"
#     else
#       if @car_status == 'on'
#         self.car_status = 'off'
#         p "Car is off"
#       end
#     end
#   end
  
#   def spray_paint(color)
#     self.color = color
#     p "Your new #{color} paint job looks great!"
#   end

#   def miles_per_gallon(gallons, miles)
#     "I get #{miles/gallons} miles per gallon!"
#   end

#   def move
#     "I am moving."
#   end

#   def info
#     puts "This vehicle is a #{color}, #{year}, #{model}."
#   end

#   def how_old
#     "This vehicle is #{age} years old"
#   end
#   private

#   def age
#     Time.now.year - year
#   end
# end

# class MyCar < Vehicle
#   NUM_DOORS = 4
# end

# class MyTruck < Vehicle
#   include Loadable
#   NUM_DOORS = 2
# end

# ruby = MyCar.new('ruby red', 'Mazda CX-5', 2018)


# frank = MyTruck.new('black', "Ford F-150", 2022)

# p ruby.how_old

class Student
  attr_accessor :name
  attr_writer :grade

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other_student)
    grade > other_student.grade
  end

  protected

  attr_reader :grade
end

jd = Student.new("JD", 100)
bob = Student.new("Bob", 98)

puts "Well done!" if jd.better_grade_than?(bob)