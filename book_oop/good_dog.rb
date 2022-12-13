module Speak
  def speak(sound)
    puts sound
  end

  def shout(word)
    puts "#{word.upcase}!!!"
  end
end

module Boop
end

class GoodDog
  include Boop
  include Speak
end

class HumanBeing
  include Speak
  include Boop
end

# sparky = GoodDog.new
# sparky.speak('Hello')

# bob = HumanBeing.new
# bob.shout('shhh I am whispering, Charlie')

# puts "---GoodDog ancestors---"
# puts GoodDog.ancestors

# puts "---HumanBeing ancestors---"
# puts HumanBeing.ancestors

#################################


### THIS PART IS NOT WORKING OR WELL UNDERSTOOD YET ###
# module Careers
#   # def speak
#   #   puts 'hi'
#   # end
  
#   class Engineer
#     include Careers
#   end

#   class Teacher
#     def speak
#       puts "you will speak when spoken to"
#     end
#   end

#   def speak
#     puts 'hi'
#   end

# end

# first_job = Careers::Teacher
# second_job = Careers::Engineer

# # first_job.speak
# second_job.speak
# first_job.speak

class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w) # constructore method. invoked by .new
    @name = n             # this is also an instance method
    @height = h
    @weight = w
  end

  def self.what_am_i  # example class method definition
    "I'm a GoodDog class!"
  end

  def speak
    "#{name} says 'Arf!'"
  end

  def change_info(n, h, w) # instance method
    self.name = n
    self.height = h
    self.weight = w
  end

  def info
    "#{name} weighs #{weight} and is #{height} tall"
  end
end

sparky = GoodDog.new("Jahova McGillinfetch", '12 inches', '10 lbs')
p sparky.info


sparky.change_info("Sparktaculus Remfolfulus", '24 inches', '45 lbs')
p sparky.info


fido = GoodDog.new("Fido Gilbesmechk", "10 cm", "19 lbs")
p fido.speak
p fido.name

p GoodDog.what_am_i
