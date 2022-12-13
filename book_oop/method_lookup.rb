module Walkable
  def walk
    "Hey! I'm walkin' hea'."
  end
end

module Swimmable
  def swim
    "Me'scusey. I am'a sweemeeng!"
  end
end

module Climbable
  def climb
    "Climb, Climb, Climbitty-Climebitty"
  end
end

class Animal
  include Walkable

  def speak
    "I'm an animal, and I speak (as all animals are wont to do)!"
  end
end

class GoodDog < Animal
  include Swimmable
  include Climbable
end


puts "---GoodDog method lookup---"
puts GoodDog.ancestors