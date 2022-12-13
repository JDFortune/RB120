# class BankAccount
#   attr_reader :balance

#   def initialize(starting_balance)
#     @balance = starting_balance
#   end

#   def positive_balance?
#     balance >= 0
#   end
# end

# jd = BankAccount.new(100_000_000.00)
# p jd.positive_balance?

# class InvoiceEntry
#   attr_reader :quantity, :product_name
#   attr_writer :quantity

#   def initialize(product_name, number_purchased)
#     @quantity = number_purchased
#     @product_name = product_name
#   end

#   def update_quantity(updated_count)
#     # prevent negative quantities from being set
#     quantity = updated_count if updated_count >= 0
#     @quantity = updated_count if updated_count >= 0
#     ||
#     self.quantity = updated_count if updated_count >= 0
#   end
# end

# class Greeting
#   def greet(message)
#     puts message
#   end
# end

# class Hello < Greeting
#   def hi
#     greet("Hello")
#   end
# end

# class Goodbye < Greeting
#   def bye
#     greet("Goodbye")
#   end
# end

# class KrispyKreme
#   attr_reader :filling_type, :glazing
  
#   def initialize(filling_type, glazing)
#     @filling_type = filling_type
#     @glazing = glazing
#   end

#   def to_s
#     @filling_type = "Plain" if @filling_type.nil?
#     @glazing ? "#{filling_type} with #{glazing}" : @filling_type
#   end
# end

# donut1 = KrispyKreme.new(nil, nil)
# donut2 = KrispyKreme.new("Vanilla", nil)
# donut3 = KrispyKreme.new(nil, "sugar")
# donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
# donut5 = KrispyKreme.new("Custard", "icing")

# puts donut1
#   # => "Plain"

# puts donut2
#   # => "Vanilla"

# puts donut3
#   # => "Plain with sugar"

# puts donut4
#   # => "Plain with chocolate sprinkles"

# puts donut5
#   # => "Custard with icing"

class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

# class Computer
#   attr_accessor :template

#   def create_template
#     self.template = "template 14231"
#   end

#   def show_template
#     self.template
#   end
# end

comp = Computer.new

comp.create_template
p comp.show_template