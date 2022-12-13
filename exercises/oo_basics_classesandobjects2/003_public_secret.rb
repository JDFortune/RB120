class Person
  attr_writer :secret

  def share_secret
    puts secret
  end

  def compare_sceret(other_person)
    secret == other_person.secret
  end
  protected

  attr_reader :secret
end

person1 = Person.new
person1.secret = "Shh.. This is a secret!"

person2 = Person.new
person2.secret = "Shh.. This is a secret!"

p person1.compare_sceret(person2)