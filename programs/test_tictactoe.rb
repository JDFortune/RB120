require 'pry'

module Displayable
  def clear_screen
    system 'clear' || 'cls'
  end
end

class Board
  MARKS = ['X', 'O']
  attr_accessor :status, :board
  WIN_STATES = [[7, 8, 9], [4, 5, 6], [1, 2, 3],
                [7, 4, 1], [8, 5, 2], [9, 6, 3],
                [7, 5, 3], [9, 5, 1]]

  def initialize
    @status = { 7 => Square.new('7'),
                8  => Square.new('8'),
                9  => Square.new('9'),
                4  => Square.new('4'),
                5  => Square.new('5'),
                6  => Square.new('6'),
                1  => Square.new('1'),
                2  => Square.new('2'),
                3  => Square.new('3') }
  end

  def full? 
    unmarked_keys.empty?
  end

  def get_square(key)
    @status[key].marker
  end

  def set_square(square, mark)
    status[square].marker = mark
  end

  def someone_won?
    MARKS.any? do |mark|
      WIN_STATES.any? do |line|
        line.all? do |key|
          get_square(key) == mark
        end
      end
    end
  end

  def detect_winner
  end

  def to_s
    "Hello"
  end

  def unmarked_keys
    status.keys.select {|key| status[key].unmarked? }
  end
end

class Square
  attr_accessor :marker
  
  def initialize(marker)
    @marker = marker
  end

  def to_s
    self.marker
  end

  def unmarked?
    ('1'..'9').include?(marker)
  end
end

class Player
  attr_reader :mark, :name
  
  MARKS = ['x', 'o']
  def initialize(mark)
    @mark = mark
    @name = get_name
  end

  def move

  end

  private
  attr_writer :mark
end

class Human < Player

  def get_name
    loop do
      puts "Enter your name: "
      input = gets.chomp
      break input if !input.strip.empty?
      puts 'Invalid name!'
    end
  end

  # def pick
  #   loop do
  #     puts 'Please pick your symbol? (x, o)'
  #     input = gets.chomp.downcase
  #     self.mark = input if MARKS.include?(input)
  #     break if mark
  #     puts 'Invalid Entry.'
  #   end
  # end
end

class Computer < Player
  NAMES = ['Hal', 'Kevin', 'Chappie', 'Billy', 'Sampson']

  def get_name
    @names  = NAMES.sample
  end
end

class TTTGame
  include Displayable

  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  attr_reader :human, :computer, :board

  def initialize
    @board = Board.new
    @human = Human.new(HUMAN_MARKER)
    @computer = Computer.new(COMPUTER_MARKER)
  end

  def display_welcome_message
    clear_screen
    puts 'Welcome to Tic Tac Toe!'
    puts ''
  end

  def display_goodbye_message
    puts 'Thanks for playing Tic Tac Toe! Goodbye'
  end

  def display_board
    clear_screen
    puts " #{human.name} is '#{human.mark}' | #{computer.name} is '#{computer.mark}'"
    puts ''
    puts '     |     |'
    puts "  #{board.get_square(7)}  |  #{board.get_square(8)}  |  #{board.get_square(9)}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{board.get_square(4)}  |  #{board.get_square(5)}  |  #{board.get_square(6)}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{board.get_square(1)}  |  #{board.get_square(2)}  |  #{board.get_square(3)}"
    puts '     |     |'
    puts ''
  end

  def set_players
    player_order = [human, computer]
    input = nil
    loop do
      puts "Who should go first? (player/computer)"
      input = gets.chomp.downcase
      break if %w(player p computer c).include?(input)
    end
    input[0] == 'p' ? player_order : player_order.reverse
  end

  def human_moves
    puts "Choose a square (#{board.unmarked_keys.sort.join(', ')}) "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice"
    end

    board.set_square(square, human.mark)
    # binding.pry
  end

  def computer_moves
    square = board.unmarked_keys.sample
    board.set_square(square, computer.mark)
  end

  def display_result
    display_board
  end

  def play
    display_welcome_message
    play_order = set_players
    loop do
      display_board
      human_moves
      break if board.someone_won? || board.full?

      computer_moves
      break if board.someone_won? || board.full?
    end
    display_result
    display_goodbye_message
  end
end

game = TTTGame.new
game.play
