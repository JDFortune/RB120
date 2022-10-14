class Animal

  def initialize(n= "Peeves, the Poltergiest")
    @name = n
  end

  def speak
    "The #{@animal}, #{@name}, says '#{@sound}'!"
  end
end

class Ghost < Animal
  def initialize(name)
    super
    @animal = "Ghost"
    @sound = "Excuse me. Pardon my asking, but do you perhaps have some lights I could flip on and off, this morn'."
  end
end

class Dog < Animal
  def initialize(name)
    super
    @animal = 'dog'
    @sound = 'woof'
  end
end

class Cat < Animal
  def initialize(name)
    super
    @animal = 'cat'
    @sound = 'meow'
  end
end

class BadDog < Animal
  def initialize(age, name)
    super(name)
    @age = age
    @animal = "bad dog"
    @sound = 'grrrr'
  end
end

bear = BadDog.new(2, "Bear")
p bear.speak