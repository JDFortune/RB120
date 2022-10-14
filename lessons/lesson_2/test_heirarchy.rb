module Boop
end

module Hulu
end

class ArcheAngel
  include Hulu
  include Boop
end




class Human

  @@human_count = 0

  def initialize
    @@human_count += 1
  end
  
  def self.how_many_humans
    @@human_count
  end

  def alter_class(command); eval command; end

  def say_hello
    puts "don't touch me!!!"
  end
end

class Peter < Human
end

harry = Human.new
bob = Human.new

bob.say_hello

harry.alter_class("@hello = 'goodday'")
p harry.alter_class('@hello') #=> 'goodday'

harry.alter_class('@hello = 4')
harry.say_hello #=> "don't touch me"

p harry.alter_class('@hello') #=> 4

p harry.alter_class("def believe; puts 'supitty dupitty'; end")
harry.say_hello #=> "supitty dupitty"


p bob.alter_class('@hello') #=> nil
bob.say_hello

p Human.how_many_humans
harry.alter_class("@@human_count = 1000")
p Human.how_many_humans

nas = Human.new
nas.say_hello
p nas.alter_class('@hello')
harry.alter_class('@hello = 4')
p nas.alter_class('@hello')

pete = Peter.new
pete.say_hello
pete.believe

p true.to_s.chars.map(&:ord)

caller.method => return

p ([] ? 'hello' : 'goodbye')
# class Human
#   attr_reader :gender, :gender_identity
  
#   def initialize
#     @gender = ['male', 'female'].sample
#     @gender_identity = ['male', 'female'].sample
#   end

#   def gender_reassignment(patient)
#     patient.gender = patient.gender_identity
#   end

    
#   protected
  
#   attr_writer :gender

#   private

#   attr_writer :gender_identity
# end

# bob = Human.new
# cheryl = Human.new
# whitney = Human.new
# greg = Human.new


class Human
  def alter_class(command); eval command; end

  def say_hello
    puts "don't touch me!!!"
  end
end



harry = Human.new

harry.alter_class("@hello = 'goodday'")
p harry.alter_class('@hello') #=> 'goodday'

harry.alter_class('@hello = 4')
p harry.alter_class('@hello') #=> 4

harry.say_hello #=> "don't touch me"
p harry.alter_class("def say_hello; puts 'supitty dupitty'; end")
harry.say_hello #=> "supitty dupitty"

bob = Human.new

p bob.alter_class('@hello') #=> nil
bob.say_hello # => "supitty dupitty"
