class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def split
    name.split
  end

  def >(other_person)
    age > other_person.age
  end

  def is_18?
    self.age >= 18
  end
end

class Team
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def <<(person)
    members.push person if person.is_a?(Person) && person.is_18?
  end

  def split
    name.split
  end

  def +(other_team)
    temp = Team.new("#{split.first} #{other_team.split.last}")
    temp.members = members + other_team.members
    temp
  end

  def [](idx)
    members[idx]
  end

  def []=(idx, obj)
    members[idx] = obj if obj.is_a? Person
  end
end

cowboys = Team.new("Dallas Cowboys")
cowboys << Person.new("Troy Aikman", 48)
cowboys << Person.new("Emmitt Smith", 46)
cowboys << Person.new("Michael Irvin", 49)


niners = Team.new("San Francisco 49ers")
niners << Person.new("Joe Montana", 59)
niners << Person.new("Jerry Rice", 52)
niners << Person.new("Deion Sanders", 47)

dream_team = cowboys + niners

p dream_team

second_player = dream_team[2].split

p second_player