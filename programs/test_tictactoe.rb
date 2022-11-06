module Displayable
  def clear_screen
    system 'clear' || 'cls'
  end
end
class Board
  MARKS = ['x', 'o']
  attr_accessor :status, :board
  WIN_STATES = [[:tl, :tm, :tr],
                [:cl, :cm, :cr],
                [:bl, :bm, :br],
                [:tl, :cl, :bl],
                [:tm, :cm, :bm],
                [:tr, :cr, :br],
                [:tl, :cm, :br],
                [:tr, :cm, :bl]]

  def initialize
    @status = { tl: Square.new('7'),
                tm: Square.new('8'),
                tr: Square.new('9'),
                cl: Square.new('4'),
                cm: Square.new('5'),
                cr: Square.new('6'),
                bl: Square.new('1'),
                bm: Square.new('2'),
                br: Square.new('3') }
  end

  def full? 
    @status.none? do |key, square|
      ('1'..'9').include?(square.marker)
    end
  end

  def get_square(key)
    @status[key]
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

  def to_s
    "Hello"
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
  def initialize(mark)
    super
  end

  def get_name
    loop do
      puts "Enter your name: "
      input = gets.chomp
      break input if !input.strip.empty?
      puts 'Invalid name!'
    end
  end

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
  def initialize(mark)
    super
  end

  def get_name
    @names  = NAMES.sample
  end
end

class TTTGame
  include Displayable

  attr_reader :human, :computer, :board

  def initialize
    @board = Board.new
    @human = Human.new("X")
    @computer = Computer.new("O")
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
    puts "Choose a square between 1-9: "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if (1..9).include?(square)
      puts "Sorry, that's not a valid choice"
    end
    board.set_square(square, human.mark)
  end

  def play
    clear_screen
    display_welcome_message
    p human
    play_order = set_players
    p play_order.map(&:name)
    unless board.someone_won? || board.full?
      display_board
      play_order.each do |player|
        player.move
        break if board.someone_won? || board.full?
      end

    end
    # display_winner
    display_goodbye_message
  end
end

game = TTTGame.new
game.play
