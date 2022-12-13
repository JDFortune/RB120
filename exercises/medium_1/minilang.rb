require 'set'

class MinilangError < StandardError; end
class BadTokenError < MinilangError; end
class EmptyStackError < MinilangError; end

class Minilang
  ACTIONS = Set.new %w(PUSH ADD SUB MULT DIV MOD POP PRINT)

  def initialize(program)
    @program = program
  end

  def eval(input = nil)
    @stack = []
    @register = 0
    @program.split.each do |token|
      if input
        eval_token(format(token, input))
      else
        eval_token(token)
      end
    end
  rescue MinilangError => error
    puts error.message
  end

  private
  attr_reader :stack
  attr_accessor :register

  def eval_token(token)
    if ACTIONS.include?(token)
      send(token.downcase)
    elsif token =~ /\A[-+]?\d+\z/
      self.register = token.to_i
    else
      raise BadTokenError, "Invalid token: #{token}"
    end
  end

  def push
    stack << register
  end

  def add
    self.register += pop
  end

  def sub
    self.register -= pop
  end
  
  def mult
    self.register *= pop
  end

  def div
    self.register /= pop
  end

  def mod
    self.register %= pop
  end

  def pop
    raise EmptyStackError, "Empty stack!" if stack.empty?
    self.register = stack.pop
  end

  def print
    puts register
  end

end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15



Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8



Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5



Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!



Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6



Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12



Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB



Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8



Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)

CENTIGRADE_TO_FAHRENHEIT = '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'

Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 100)).eval
Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 0)).eval
Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: -40)).eval
Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: -80)).eval

minilang = Minilang.new(CENTIGRADE_TO_FAHRENHEIT)
minilang.eval(degrees_c: 100)