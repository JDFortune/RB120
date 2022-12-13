class GoodDog
  attr_accessor :name, :height, :weight
  DOG_YEARS = 7
  @@num_dogs = 0
  def initialize(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
    @@num_dogs += 1
  end

  def self.awareness
    puts "I am a Good Dog and therefore, I bark at mailmen (and mailwomen!!!)."
  end

  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end

  def info
    "#{name} weights #{weight} and is #{height} tall."
  end

  def what_is_self
    self
  end

  def self.count_it_up
    puts "#{@@num_dogs} GoodDog object(s)"
  end
end

teddy = GoodDog.new("Teddy", "9 feet", "150lbs")
# p teddy.what_is_self
GoodDog.count_it_up
# GoodDog::awareness
bean_bag = GoodDog.new("BeanBagJill", 7, 150)
GoodDog.count_it_up
p GoodDog::DOG_YEARS