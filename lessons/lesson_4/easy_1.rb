# module Speed
#   def go_fast
#     puts "I am a #{self.class} and going super fast!"
#   end
# end

# class Car
# include Speed

#   def go_slow
#     puts "I am safe and driving slow."
#   end
# end

# class Truck
#   include Speed

#   def go_very_slow
#     puts "I am a heavy truck and like going very slow."
#   end
# end

# p Car.ancestors
# p Truck.ancestors

# class AngryCat
  
#   def initialize(name)
#     @name = name
#     @hope = 'hello'
#     @bull = 'bello'
#     @krull = 'alien'
#   end

#   def hiss
#     puts "Hisssss!!!"
#   end
# end

# sassy = AngryCat.new("Sassy")

# variables = sassy.instance_variables

# variables.each do |var|
#   puts "#{var} is #{sassy.instance_variable_get(var)}"
# end


# class Cat
#   attr_accessor :type, :age

#   def initialize(type)
#     @type = type
#     @age  = 0
#   end

#   def make_one_year_older
#     self.age += 1
#   end
# end

# cat = Cat.new('Calico')
# p cat.age
# p cat.make_one_year_older
# p cat.make_one_year_older
# p cat.age

class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

p purse = Bag.new('blue', 'suede')