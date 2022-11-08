module Displayable
  def clear_screen
    system 'clear' || 'cls'
  end
end

class GuessingGame
  RANGE = 1..100

  include Displayable
  def initialize
    @guess = nil
    @max_attempts = 7
  end

  def play
    reset
    clear_screen
    loop do
      say_remaining_guesses
      get_guess
      evaluate_guess
      break if guess == number || attempts == max_attempts
    end
   say_game_over
  end

  def change_max_attempts(num)
    self.max_attempts = num if num > 0
  end

  private

  attr_accessor :guess, :attempts, :number, :max_attempts

  def reset
    self.number = rand(RANGE)
    self.attempts = max_attempts
  end

  def say_remaining_guesses
    puts "You have #{attempts} guesses remaining."
  end

  def get_guess
    loop do
      puts "Enter a number between 1 and 100?"
      input = gets.chomp.to_i
      break self.guess = input if RANGE === input
      print "Invalid guess."
    end
    self.attempts -= 1
  end

  def evaluate_guess
    if guess > number
      puts "Your guess is too high."
    elsif guess < number
      puts "Your guess is too low."
    else
      puts "\nThat's the number!"
    end
  end

  def say_game_over
    if guess == number 
      puts "\nYou Won!\nYou had #{attempts} attemps remianing."
    else
      puts "\nOut of Guesses!!\nThe number was #{number}.\nYou Lose."
    end
  end
end

game = GuessingGame.new
game.play

=begin
module Displayable
  def clear_screen
    system 'clear' || 'cls'
  end
end

class GuessingGame
  include Displayable

  def initialize( low = 1, high = 100)
    @guess = nil
    @range = low < high ? (low..high) : (high..low)
    @max_attempts = Math.log2(high - low).ceil
  end

  def play
    reset
    clear_screen
    loop do
      say_remaining_guesses
      get_guess
      evaluate_guess
      break if guess == number || attempts == 0
    end
   say_game_over
  end

  def change_max_attempts(num)
    self.max_attempts = num if num > 0
  end

  private

  attr_accessor :guess, :attempts, :number, :max_attempts, :range

  def reset
    self.number = rand(range)
    self.attempts = max_attempts
  end

  def say_remaining_guesses
    puts "You have #{attempts} guesses remaining."
  end

  def get_guess
    loop do
      puts "Enter a number between #{range.first} and #{range.last}?"
      input = gets.chomp.to_i
      break self.guess = input if range === input
      print "Invalid guess. "
    end
    self.attempts -= 1
  end

  def evaluate_guess
    if guess > number
      puts "Your guess is too high."
    elsif guess < number
      puts "Your guess is too low."
    else
      puts "\nThat's the number!"
    end
  end

  def say_game_over
    if guess == number 
      puts "\nYou Won!\nYou had #{attempts} attemps remianing."
    else
      puts "\nOut of Guesses!!\nThe number was #{number}.\nYou Lose."
    end
  end
end

game = GuessingGame.new(1, 10)
game.play
=end