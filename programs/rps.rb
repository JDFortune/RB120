class Move
  attr_reader :value

  VALUE = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  WINS = {
    'rock' => {'scissors' => 'rock smashes scissors', 'lizard' => 'rock smashes lizard'},
    'scissors' => {'paper' => 'scissors cut paper', 'lizard' => 'scissors decapitate lizard'},
    'paper' => {'rock' => 'paper covers rock', 'spock' => 'paper disproves spock'},
    'spock' => {'scissors' => 'spock smashes scissors', 'rock' => 'spock vaporizes rock'},
    'lizard' => {'paper' => 'lizard eats paper', 'spock' => 'lizard poisons spock'}
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
    puts WINS[value][loser.move.value].upcase + "!!!"
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
      puts "Please choose, rock, paper, scissors, lizard, or spock:"
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
  attr_accessor :board

  def initialize(player1, player2)
    @board = { player1.name => 0, player2.name => 0, "Tie" => 0}
  end

  def add(player)
    board[player] += 1
  end

  def to_s
    puts''
    puts "==============="
    puts "     Score     "
    puts "==============="
    board.each do |name, points|
      puts ("#{name}:  #{points}").rjust(11)
    end
    puts "==============="
    ''
  end 
end

class RPSGame
  attr_accessor :human, :computer, :score

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
    message = <<~MSG
      The Rules are as follows:
        - Rock smashes scissors and crushes lizard
        - Paper disproves spock and covers rock
        - Scissors cut paper and decapitate lizard
        - Lizard poisons spock and eats paper
        - Spock vaporizes rock and smashes scissors

    <Press Enter to Begin>
    MSG
    puts message
    gets
  end

  def display_goodbye_message
    message = <<~MESSAGE
        Thanks for playing!
        I guess this is goodbye, isn't it #{human.name}.
        I'll never forget this time we spent together."
    MESSAGE

    puts message
  end

  def display_winner
    if human.move > computer.move
      winner = human
    elsif human.move < computer.move
      winner = computer
    else
      puts "It's a tie!"
      winner = 'Tie'
    end
    loser = winner == human ? computer : human
    puts "#{winner.name} wins!"
    score.add(winner.name)
    winner.move.action_sequence(loser)
  end

  def display_moves
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
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
  end
end

RPSGame.new.play
