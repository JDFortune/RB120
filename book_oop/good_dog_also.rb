class GoodDog
  @@number_of_dogs = 0

  DOG_YEARS = 7
  attr_accessor :name, :age

  def initialize(n, a)
    @@number_of_dogs += 1
    self.name = n
    self.age = a
  end

  def self.total_number_of_dogs
    @@number_of_dogs
  end
  def public_disclosure
    "#{name} in dog years is #{self.dog_years}"
  end
  private

  def dog_years
    age * DOG_YEARS
  end
end

sparky = GoodDog.new("Sparky", 4)

p sparky.public_disclosure

p GoodDog.total_number_of_dogs