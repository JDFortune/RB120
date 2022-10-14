class Owner
  attr_reader :name
  attr_accessor :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def number_of_pets; @pets.size; end
end

class Pet
  attr_reader :name, :type

  def initialize(type, name)
    @type = type
    @name = name
  end

  def to_s
    "a #{type} named #{name}"
  end
end

class Shelter
  attr_reader :adoptions, :unadopted_pets, :name

  def initialize(unadopted_pets = [])
    @name = "The Animal Shelter"
    @adoptions = Hash.new { |hash, key| hash[key] = []}
    @unadopted_pets = unadopted_pets
  end

  def adopt(owner, pet)
    if unadopted_pets.include?(pet)
      owner.pets << unadopted_pets.delete(pet)
      @adoptions[owner.name] << pet
    else
      puts "The #{pet.type}, #{pet.name}, is not in this shelter."
    end
  end

  def add_pets(*pets)
    pets.flatten! if pets.first.is_a?(Array)
    self.unadopted_pets << pets.shift until pets.empty?
  end

  def print_adoptable_pets
    puts "The Animal Shelter has the following unadopted pets:", unadopted_pets, ''
  end

  def print_adoptions
    @adoptions.each { |owner, pets| puts "#{owner} has adopted the following pets:", pets, '' }
  end
end

##############################################################
butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter_pets = [butterscotch, pudding, darwin, kennedy, sweetie, molly, chester]

shelter = Shelter.new(shelter_pets)
shelter.print_adoptable_pets
puts ''
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts "#{shelter.name} has #{shelter.unadopted_pets.size} unadopted pets.", ''
shelter.adopt(bholmes, chester)   # shows animal is no longer in shelter once adopted
puts ''

shelter.add_pets([molly.clone, darwin.clone, kennedy.clone]) #adding as an array
shelter.add_pets(sweetie.clone, pudding.clone, darwin.clone) #adding as individual arguments
shelter.add_pets(butterscotch.clone) #adding as single argument
shelter.print_adoptable_pets
puts "#{shelter.name} has #{shelter.unadopted_pets.size} adopted pets."