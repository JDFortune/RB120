module Swimmable
  def swim
    "I am swimming!"
  end
end

class Animal; end

class Fish < Animal
  include Swimmable
end

class Mammal < Animal
end

class Dog < Mammal
  include Swimmable
end

class Cat < Mammal
end

sparky = Dog.new
nemo = Fish.new
ollie = Cat.new

p sparky.swim
p nemo.swim
p ollie.swim
