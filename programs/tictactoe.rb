module Displayable
  def clear_screen
    system 'clear' || 'cls'
  end
end

module TicTacToe
  class Board
    RESET = %w(7 8 9 4 5 6 1 2 3)
    MARKS = ['X', 'O']
    attr_accessor :squares

    def initialize
      @squares = {}
      reset
    end

    def reset
      RESET.each do |num|
        squares[num.to_i] = Square.new(num)
      end
    end

    def join_available_squares
      available = unmarked_keys.sort.map(&:to_s)

      case available.size
      when 1
        available.join
      when 2
        available.first + ' ' + available.last
      else
        available[0..-2].join(', ') + ', or ' + available.last
      end
    end

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    def draw
      puts ''
      puts '     |     |'
      puts "  #{squares[7]}  |  #{squares[8]}  |  #{squares[9]}"
      puts '     |     |'
      puts '-----+-----+-----'
      puts '     |     |'
      puts "  #{squares[4]}  |  #{squares[5]}  |  #{squares[6]}"
      puts '     |     |'
      puts '-----+-----+-----'
      puts '     |     |'
      puts "  #{squares[1]}  |  #{squares[2]}  |  #{squares[3]}"
      puts '     |     |'
      puts ''
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength

    def full?
      unmarked_keys.empty?
    end

    def []=(square, mark)
      squares[square].marker = mark
    end

    def to_s
      "Hello"
    end

    def unmarked_keys
      squares.keys.select { |key| squares[key].unmarked? }
    end

    def count_marks(line, marker)
      group = squares.select { |pos, _| line.include?(pos) }
      group.values.count { |sq| sq.marker == marker }
    end

    def count_unmarked(line)
      squares.select { |pos, _| line.include?(pos) }.values.count(&:unmarked?)
    end
  end

  class Square
    attr_accessor :marker

    def initialize(marker)
      @marker = marker
    end

    def to_s
      marker
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
      @name = input_name
    end

    def to_s
      name
    end

    private

    attr_writer :mark
    attr_accessor :board
  end

  class Human < Player
    def initialize(board)
      super(board)
      pick_mark
    end

    def input_name
      loop do
        puts "Enter your name: "
        input = gets.chomp
        break input if !input.strip.empty?
        puts 'Invalid name!'
      end
    end

    def move
      puts "Choose a square: #{board.join_available_squares}"
      square = nil
      loop do
        square = gets.chomp.to_i
        break if board.unmarked_keys.include?(square)
        puts "Sorry, that's not a valid choice"
      end
      board[square] = mark
    end

    def pick_mark
      loop do
        puts 'Please pick your symbol? (X, O)'
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
      @opponent_marker = (MARKS - [mark]).first
    end

    def input_name
      @names = NAMES.sample
    end

    def move
      square = strategy || board.unmarked_keys.sample
      board[square] = mark
    end

    private

    def strategy
      middle = board.squares[5].unmarked? ? 5 : false
      square = offense || defense || setup || middle
      return nil unless square
      square
    end

    def offense
      Game::WIN_STATES.each do |line|
        if board.count_marks(line, mark) == 2 && board.count_unmarked(line) == 1
          line.each { |sq| return sq if board.squares[sq].unmarked? }
        end
      end
      nil
    end

    def defense
      Game::WIN_STATES.each do |line|
        if board.count_marks(line, opponent_marker) == 2 &&
           board.count_unmarked(line) == 1
          line.each { |sq| return sq if board.squares[sq].unmarked? }
        end
      end
      nil
    end

    def setup
      Game::WIN_STATES.each do |line|
        if board.count_marks(line, mark) == 1 && board.count_unmarked(line) == 2
          line.each { |sq| return sq if board.squares[sq].unmarked? }
        end
      end
      nil
    end

    attr_reader :opponent_marker
  end

  class Score
    def initialize(player1, player2)
      @score = { player1 => 0, player2 => 0, 'Tie' => 0 }
    end

    def add(name)
      score[name] += 1
    end

    def to_s
      score_width = 18
      puts ''
      puts '-' * score_width
      puts 'Score'.center(score_width)
      puts '-' * score_width
      score.each do |player, points|
        puts " #{player}:".rjust(9) + " #{points}"
      end
      puts '-' * score_width
      ''
    end

    private

    attr_reader :score
  end

  class Game
    include Displayable
    WIN_STATES = [[7, 8, 9], [4, 5, 6], [1, 2, 3],
                  [7, 4, 1], [8, 5, 2], [9, 6, 3],
                  [7, 5, 3], [9, 5, 1]]

    def initialize
      @board = Board.new
      @human = Human.new(board)
      @computer = Computer.new(computer_marker, board)
      @score = Score.new(human.name, computer.name)
    end

    def play
      display_welcome_message
      main_game
      display_goodbye_message
    end

    def computer_marker
      (Board::MARKS - [human.mark]).first
    end

    private

    attr_accessor :players, :winner, :current_player, :score
    attr_reader :human, :computer, :board

    def main_game
      loop do
        board.reset
        set_players
        player_move
        display_result
        display_score
        break unless play_again?
      end
    end

    def play_again?
      answer = nil
      loop do
        puts "Would you like to play again? (y/n)"
        answer = gets.downcase.chomp.strip
        break if %w(y yes n no).include?(answer)
        puts "Invalid input."
      end
      %w(y yes).include?(answer)
    end

    def display_welcome_message
      clear_screen
      puts 'Welcome to Tic Tac Toe!'
      puts ''
    end

    def display_goodbye_message
      clear_screen
      puts "Thanks for playing Tic Tac Toe, #{human}! Goodbye!"
      puts score
    end

    def display_board
      clear_screen
      puts " #{human} is '#{human.mark}' | #{computer} is '#{computer.mark}'"
      board.draw
    end

    def display_score
      puts score
    end

    def set_players
      self.players = [human, computer]
      input = nil
      loop do
        puts "Who should go first? (human/computer)"
        input = gets.chomp.downcase.strip
        break if %w(human h computer c comp).include?(input)
      end
      self.current_player = input.start_with?('h') ? human : computer
    end

    def current_player_move
      if current_player == human
        human.move
        self.current_player = computer
      else
        computer.move
        self.current_player = human
      end
    end

    def player_move
      loop do
        display_board
        current_player_move
        break self.winner = winning_marker if someone_won? || board.full?
      end
    end

    def someone_won?
      !!winning_marker
    end

    def winning_marker
      players.each do |player|
        WIN_STATES.any? do |line|
          return player if board.count_marks(line, player.mark) == 3
        end
      end
      nil
    end

    def display_result
      display_board
      if winner
        puts "#{winner} won!"
        score.add(winner.name)
      else
        puts "It's a tie"
        score.add('Tie')
      end
    end
  end
end

game = TicTacToe::Game.new
game.play
