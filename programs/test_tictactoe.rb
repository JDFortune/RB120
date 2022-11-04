module Displayable
  def clear_screen
    system 'clear' || 'cls'
  end
end
class Board
  attr_accessor :status
  WIN_STATES = [[:tl, :tm, :tr],
                [:cl, :cm, :cr],
                [:bl, :bm, :br],
                [:tl, :cl, :bl],
                [:tm, :cm, :bm],
                [:tr, :cr, :br],
                [:tl, :cm, :br],
                [:tr, :cm, :bl]]

  def initialize
    @status = {tl: Square.new(7), tm: Square.new(8), tr: Square.new(9), cl: Square.new(4), cm: Square.new(5), cr: Square.new(6), bl: Square.new(1), bm: Square.new(2), br: Square.new(3)}
  end

  def to_s
    puts ""
  end

  def full? 
    !@status.none? do |key, square|
      (1..9).include?(square.value)
    end
  end

  def get_square(square)
    status[square].value
  end

  def someone_won?(order)
    test = []
    # order.each do |player|
      WIN_STATES.any? do |line|
        temp = []
        line.each? do |key|
          temp << @status[key]
        end
        test << temp
      end
    # end
    test
  end

  private
  attr_reader :board
end

class Square
  attr_accessor :value
  def initialize(temp)
    @value = temp
  end
end

class Player
  attr_reader :mark, :name
  
  MARKS = ['x', 'o']
  def initialize
    @name = get_name
  end

  def get_name
    loop do
      puts "Enter your name: "
      input = gets.chomp
      break input if !input.strip.empty?
      puts 'Invalid name!'
    end
  end

  def move

  end

  private
  attr_writer :mark
end

class Human < Player
  def pick
    loop do
      puts 'Please pick your symbol? (x, o)'
      input = gets.chomp.downcase
      self.mark = input if MARKS.include?(input)
      break if mark
      puts 'Invalid Entry.'
    end
  end
end

class Computer < Player
  NAMES = ['Hal', 'Kevin', 'Chappie', 'Billy', 'Sampson']
  def initialize
    @name = NAMES.sample
  
  end
end

class TTTGame
  include Displayable

  attr_reader :player, :computer, :board

  def initialize
    @board = Board.new
  end

  def display_welcome_message
    puts 'Welcome to Tic Tac Toe!'
    puts ''
  end

  def display_goodbye_message
    puts 'Thanks for playing Tic Tac Toe! Goodbye'
  end

  def display_board
    puts ''
    puts '     |     |'
    puts "  #{board.get_square(:tl)}  |  #{board.get_square(:tm)}  |  #{board.get_square(:tr)}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{board.get_square(:cl)}  |  #{board.get_square(:cm)}  |  #{board.get_square(:cr)}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{board.get_square(:bl)}  |  #{board.get_square(:bm)}  |  #{board.get_square(:br)}"
    puts '     |     |'
    puts ''
  end

  def set_players
    player_order = [@player, @computer]
    input = nil
    loop do
      puts "Who should go first? (player/computer)"
      input = gets.chomp.downcase
      break if %w(player p computer c).include?(input)
    end
    input[0] == 'p' ? player_order : player_order.reverse
  end

  def someone_won?
  end 
  def play
    clear_screen
    display_welcome_message
    @player = Human.new
    puts player.name
    @computer = Computer.new
    puts computer.name
    display_board
    unless someone_won? || board.full?
      display_board
      play_order = set_player

      play_order.each do |player|
        player.move
        break if someone_won? || board.full?
      end

    end
    # display_winner
    display_goodbye_message
  end
end

game = TTTGame.new
game.play

# game.display_board
# p "#{Board.new.get_square(:tl)}"