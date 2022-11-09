require 'pry'

module Displayable
  def clear_screen
    system 'clear' || 'cls'
  end
end

class Board
  RESET = %w(7 8 9 4 5 6 1 2 3)
  MARKS = ['X', 'O']
  attr_accessor :status, :board

  def initialize
    @status = {}
    reset
  end
  
  def reset
    RESET.each do |num|
      status[num.to_i] = Square.new(num)
    end
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
  
  MARKS = ['X', 'O']
  def initialize(board)
    @board = board
    @name = get_name
    get_mark
  end

  private
  attr_writer :mark
  attr_accessor :board
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

  def move
    puts "Choose a square (#{board.unmarked_keys.sort.join(', ')}) "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice"
    end
    board.set_square(square, mark)
  end

  def get_mark
    loop do
      puts 'Please pick your symbol? (x, o)'
      input = gets.chomp.upcase
      self.mark = input if MARKS.include?(input)
      break if mark
      puts 'Invalid Entry.'
    end
  end
end

class Computer < Player
  NAMES = ['Hal', 'Kevin', 'Chappie', 'Billy', 'Sampson']
  def initialize(mark, board)
    super(board)
    @mark = mark
  end

  def get_name
    @names  = NAMES.sample
  end

  def get_mark
    @mark
  end

  def move
    # if strategy
    #   strategy
    # else
    #   sample_the_board
    # end
    square = board.unmarked_keys.sample
    board.set_square(square, mark)
  end

  def strategy
    if offense
      return offense
    elsif defense
      return defense
    end
    nil
  end

  def offense
  end

  def defense
  end
end

class TTTGame
  include Displayable
  WIN_STATES = [[7, 8, 9], [4, 5, 6], [1, 2, 3],
                [7, 4, 1], [8, 5, 2], [9, 6, 3],
                [7, 5, 3], [9, 5, 1]]

  def initialize
    @board = Board.new
    @human = Human.new(board)
    @computer = Computer.new(computer_marker, board)
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.downcase.chomp
      break if %w(y n).include?(answer)
    end
    answer == 'y'
  end

  def play
    display_welcome_message
    loop do
      board.reset
      self.play_order = set_players

      until someone_won? || board.full?
        play_order.each do |player|
          display_board
          player.move
          break self.winner = winning_marker if someone_won? || board.full?
        end
      end

      display_result
      break unless play_again?
    end
    display_goodbye_message
  end

  def computer_marker
    (Board::MARKS - [human.mark]).first
  end

  private
  attr_accessor :play_order, :winner
  attr_reader :human, :computer, :board

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

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    play_order.each do |player|
      WIN_STATES.any? do |line|
        return player if line.all? do |key|
          board.get_square(key) == player.mark
        end
      end
    end
    nil
  end

  def display_result
    display_board
    if winner
      puts "#{winning_marker.name} won!!"
    else
      puts "It's a tie"
    end
  end
end

game = TTTGame.new
game.play
