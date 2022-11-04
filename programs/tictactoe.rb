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
    @status = {tl: '7', tm: '8', tr: '9', cl: '4', cm: '5', cr: '6', bl: '1', bm: '2', br: '3'}
  end

  def to_s
    puts ""
  end

  def full
    !@status.values.match?(/[1-9]/)
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
  def initialize
    @status = nil
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

  attr_reader :player, :computer

  def display_welcome_message
    puts 'Welcome to Tic Tac Toe!'
    puts ''
  end

  def display_goodbye_message
    puts 'Thanks for playing Tic Tac Toe! Goodbye'
  end

  def display_board(brd)
    puts ''
    puts '     |     |'
    puts "  #{brd.status[:tl]}  |  #{brd.status[:tm]}  |  #{brd.status[:tr]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{brd.status[:cl]}  |  #{brd.status[:cm]}  |  #{brd.status[:cr]}"
    puts '     |     |'
    puts '-----+-----+-----'
    puts '     |     |'
    puts "  #{brd.status[:bl]}  |  #{brd.status[:bm]}  |  #{brd.status[:br]}"
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

  def play
    clear_screen
    display_welcome_message
    board = Board.new
    @player = Human.new
    puts player.name
    @computer = Computer.new
    puts computer.name
    unless someone_won? || board.full? do
      display_board(board)
      play_order = set_player
      play_order.each do |player|
        player.move
        break if someone_won? || board.full?
    end
    # display_winner
    display_goodbye_message
  end
end

game = TTTGame.new
game.play
