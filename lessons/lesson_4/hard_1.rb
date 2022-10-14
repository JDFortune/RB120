# module Moveable
#   attr_accessor :speed, :heading
#   attr_writer :fuel_capacity, :fuel_efficiency

#   def range
#     @fuel_capacity * @fuel_efficiency
#   end
# end

# class WheeledVehicle
#   include Moveable

#   def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
#     @tires = tire_array
#     self.fuel_efficiency = km_traveled_per_liter
#     self.fuel_capacity = liters_of_fuel_capacity
#   end

#   def tire_pressure(tire_index)
#     @tires[tire_index]
#   end

#   def inflate_tire(tire_index, pressure)
#     @tires[tire_index] = pressure
#   end
# end

# class Auto < WheeledVehicle
# end

# class Motorcycle < WheeledVehicle
# end

# class Seacraft
#   include Moveable

#   attr_reader :propeller_count, :hull_count

#   def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
#     @propeller_count = num_propellers
#     @hull_count = num_hulls
#     self.fuel_efficiency = km_traveled_per_liter
#     self.fuel_capacity = liters_of_fuel_capacity
#   end

#   def range
#     super + 10
#   end
# end

# class Catamaran < Seacraft; end

# class Motorboat < Seacraft
#   def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
#     super(1, 1, km_traveled_per_liter, liters_of_fuel_capacity)
#   end
# end

# cat = Catamaran.new(5, 5, 80, 25.0)
# mot = Motorcycle.new([20,20], 80, 8.0)
# aut = Auto.new([30,30,32,32], 50, 25.0)
# mob = Motorboat.new(50, 25.0)

# p cat.range
# p mot.range
# p aut.range
# p mob.range
# SUFFIX = { 1 => "st", 2 => 'nd', 3 => 'rd'}
# def century(year)
#   cent = year.fdiv(100).ceil
#   tenths = cent.digits[0,2].reverse.join.to_i
#   first = tenths.digits.first
#   return (SUFFIX.include?(cent) ? "#{cent}#{SUFFIX[cent]}" : "#{cent}th") if tenths.nil?

#   (SUFFIX.keys.include?(first) && !tenths.between?(10, 20)) ?
#     "#{cent}#{SUFFIX[first]}" :
#     "#{cent}th"
# end

# p century(2000)  == '20th'
# century(2001) == '21st'
# century(1965) == '20th'
# century(256) == '3rd'
# p century(5) == '1st'
# p century(10103) == '102nd'
# p century(1052) == '11th'
# p century(1127) == '12th'
# p century(11201)  == '113th'

def ascii_value(string)
  string.chars.map(&:ord).sum
end

p ascii_value('Four score') == 984
p ascii_value('Launch School') == 1251
p ascii_value('a') == 97
p ascii_value('') == 0