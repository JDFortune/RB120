class Person
  attr_accessor :pets, :name

  def initialize(name)
    @name = name
    @pets = []
  end
end


class Animal
  attr_accessor :name
  def initialize(name)
    @name = name
  end

  def jump
    "#{name} jumps!"
  end
end

class Dog < Animal; end

class Cat < Animal; end

garry = Person.new("Garry")
max = Dog.new('Max')
sarah = Cat.new('Sarah')

garry.pets << max
garry.pets << sarah

p garry.pets.find {|pet| pet.name == 'Max'}.jump