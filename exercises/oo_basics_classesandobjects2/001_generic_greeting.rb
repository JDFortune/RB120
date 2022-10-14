class Cat
  attr_accessor :name

  @@total = 0

  def initialize(name)
    @name = name
    @@total += 1
  end

  def self.generic_greeting
    puts "Hello! I am a cat!"
  end

  def self.total
    @@total
  end

  def personal_greeting
    puts "Hello! My name is #{name}!"
  end

  def rename(name)
    self.name = name
  end

  def identify
    self
  end
end

p Cat.total

kitty1 = Cat.new("Sophie")
kitty2 = Cat.new("Melinda")

p Cat.total