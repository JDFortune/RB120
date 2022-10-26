# module ElizabethanEra
#   GREETINGS = ['How dost thou', 'Bless thee', 'Good morrow']

#   class Person
#     def self.greetings
#       GREETINGS.join(', ')
#     end

#     def greet
#       GREETINGS.sample
#     end
#   end
# end

# puts ElizabethanEra::Person.greetings # => "How dost thou, Bless thee, Good morrow"
# puts ElizabethanEra::Person.new.greet # => "Bless thee" (output may vary)

# class Animal
#   def initialize(name)
#     @name = name
#   end
# end

# class Dog < Animal
#   def dog_name
#     "bark! bark! #{@name} bark! bark!"
#   end
# end

# teddy = Dog.new("Teddy")
# puts teddy.dog_name

# module FourWheeler
#   WHEELS = 4
# end

# class Vehicle
#   WHEELS = 4
#   def maintenance
#     "Changing #{WHEELS} tires."
#   end

#   def say_it
#     puts @hello
#   end
# end

# class Car < Vehicle
#   WHEELS = 2
#   include FourWheeler
#   def initialize
#     @hello = 'howdy'
#   end
#   def wheels
#     WHEELS
#   end
# end

# car = Car.new
# puts car.wheels        # => 4
# car.say_it
# puts car.maintenance   # => NameError: uninitialized constant Maintenance::WHEELS

# puts Car::WHEELS
# puts Vehicle::WHEELS

# class Vehicle
#   @wheels = 4

#   def self.wheels
#     @wheels
#   end
# end

# class Motorcycle < Vehicle
#   @wheels = 2
# end

# class Thing
#   attr_accessor :size

#   def initialize(s)
#     @size = s
#   end

#   def ==(other_thing)
#     size == other_thing.size
#   end
# end

# thing1 = Thing.new(5)
# thing2 = Thing.new(5)
# thing3 = thing1
# thing1.size = 4

# p thing1.size
# p thing2.size
# p thing3.size

# p thing3.object_id
# p thing1.object_id

module Describable
  def describe_shape
    "I am a #{self.class} and have #{self.class::SIDES} sides."
  end
end

class Shape
  include Describable

  def self.sides
    self::SIDES
  end
end

class Quadrilateral < Shape
  SIDES = 4


  def sides
    SIDES
  end
end

class Square < Quadrilateral

end

p Square.sides # => 4
p Square.new.sides # => 4
p Square.new.describe_shape # => "I am a Square and have 4 sides."

hat = 'baseball cap'

def method
  hat = 'fedora'
end

p hat

1.times do
  hat = 'visor'
end

p hat