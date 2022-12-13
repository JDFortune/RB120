# class Greeting
#   def greet(message)
#     puts message
#   end
# end

# class Hello < Greeting
#   def self.hi
#     greeting = Greeting.new
#     greeting.greet('Hello')
#   end
# end

# class Goodbye < Greeting
#   def bye
#     greet("Goodbye")
#   end
# end

# Hello.hi

# class AngryCat
#   def initialize(age, name)
#     @age  = age
#     @name = name
#   end

#   def age
#     puts @age
#   end

#   def name
#     puts @name
#   end

#   def hiss
#     puts "Hisssss!!!"
#   end
# end


# furry = AngryCat.new(23, "Fury")
# hamburg = AngryCat.new(6, "Hamber")

class Cat
  attr_reader :type
  
  def initialize(type)
    @type = type
  end

  def to_s
    "I am a #{type} cat"
  end
end

harry = Cat.new('styles')

puts harry