class Person
  def initialize
    @age = 0
  end

  def age=(age)
    @age = double(age)
  end

  def age
    double(@age)
  end

  private

  def double(age)
    age * 2
  end
end

person1 = Person.new
person1.age = 20
puts person1.age