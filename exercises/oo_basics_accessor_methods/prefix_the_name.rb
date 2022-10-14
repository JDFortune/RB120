class Person

  def name=(name)
    @name = name.capitalize
  end

  def name
    "Mr. #{@name}"
  end
end

person1 = Person.new
person1.name = 'James'
puts person1.name