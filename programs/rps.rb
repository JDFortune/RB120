RULES = <<~MSG
The Rules are as follows:
  - Rock smashes scissors and crushes lizard
  - Paper disproves spock and covers rock
  - Scissors cut paper and decapitate lizard
  - Lizard poisons spock and eats paper
  - Spock vaporizes rock and smashes scissors

<Press Enter to Begin>
MSG

class Move
  attr_reader :value

  VALUE = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  WINS = {
    'rock' => { 'scissors' => 'rock smashes scissors',
                'lizard' => 'rock smashes lizard' },
    'scissors' => { 'paper' => 'scissors cut paper',
                    'lizard' => 'scissors decapitate lizard' },
    'paper' => { 'rock' => 'paper covers rock',
                 'spock' => 'paper disproves spock' },
    'spock' => { 'scissors' => 'spock smashes scissors',
                 'rock' => 'spock vaporizes rock' },
    'lizard' => { 'paper' => 'lizard eats paper',
                  'spock' => 'lizard poisons spock' }
  }

  def initialize(value)
    @value = value
  end

  def >(other_move)
    wins = WINS[value].keys
    wins.include?(other_move.value) && value != other_move.value
  end

  def <(other_move)
    wins = WINS[value].keys
    !wins.include?(other_move.value) && value != other_move.value
  end

  def action_sequence(loser)
    puts ''
    puts WINS[value][loser.move.value].upcase + "!!!"
    puts ''
  end

  def ==(other_move)
    value == other_move.value
  end

  def to_s
    value
  end
end

class Player
  attr_accessor :move, :name

  def initialize
    set_name
  end

  def to_s
    name
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What is your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, you must enter a name."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose 'rock', 'paper', 'scissors', 'lizard', or 'spock':"
      choice = gets.chomp.downcase
      break if Move::VALUE.include?(choice)
      puts "Invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'No. 5'].sample
  end

  def choose
    self.move = Move.new(Move::VALUE.sample)
  end
end

class Score
  attr_accessor :board, :history

  def initialize(player1, player2)
    @board = { player1.name => 0, player2.name => 0, "Tie" => 0 }
    @history = {}
  end

  def add(player)
    board[player] += 1
  end

  def to_s
    puts ''
    puts "==============="
    puts "  Score Board  "
    puts "==============="
    board.each do |name, points|
      puts ("#{name}:  #{points}").rjust(11)
    end
    puts "==============="
    ''
  end

  def add_history(human, computer, winner)
    history["Game #{history.size + 1}"] =
      "[#{human}: #{human.move}, #{computer}: #{computer.move}, winner: #{winner}]"
  end

  def display_history
    history.each do |game, results|
      puts game + (" " * (9 - game.size)) + "| #{results}"
    end
  end
end

class RPSGame
  attr_accessor :human, :computer, :score, :winner

  def initialize
    @human = Human.new
    @computer = Computer.new
    @score = Score.new(human, computer)
  end

  def display_welcome_message
    clear_screen
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
    sleep(1)
  end

  def display_rules
    puts RULES
    gets
  end

  def display_goodbye_message
    print "Time to wake up."
    2.times do
      sleep(0.5)
      print '.'
    end
    puts ''
  end

  def determine_winner
    self.winner = human.move == computer.move ? "Tie" : nil
    unless winner
      self.winner = human.move > computer.move ? human : computer
    end
    score.add_history(human, computer, winner.to_s)
  end

  def display_winner
    determine_winner
    if winner == "Tie"
      score.add(winner)
    else
      loser = ([human, computer] - [winner]).first
      winner.move.action_sequence(loser)
      puts "#{winner.name} wins!"
      score.add(winner.name)
    end
  end

  def display_moves
    puts "#{human} chose #{human.move}"
    puts "#{computer} chose #{computer.move}"
  end

  def play_again?
    again = nil
    loop do
      puts "Would you like to play again? (y/n)"
      again = gets.chomp
      break if ['y', 'n'].include?(again)
      puts "Invalid Entry"
    end
    again.downcase == 'y'
  end

  def clear_screen
    system 'clear' || 'cls'
  end

  def see_history?
    answer = nil
    loop do
      puts "Would you like to view your score history? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Please enter 'y' or 'n'."
    end
    score.display_history if answer == 'y'
  end

  def play
    display_welcome_message
    display_rules
    loop do
      clear_screen
      human.choose
      computer.choose
      display_moves
      display_winner
      puts score
      break unless play_again?
    end
    clear_screen
    display_goodbye_message
    puts score
    see_history?
  end
end

RPSGame.new.play
