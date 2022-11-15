require 'pry'

module Validatable
  def is_number?(num)
    num.match?(/[0-9]/)
  end

  def hit_or_stay
    answer = nil
    loop do
      puts "Would you like to 'hit' or 'stay'?"
      input = gets.chomp.downcase
      break answer = input[0] if %w(hit stay h s).include?(input)
      puts "Invalid input."
    end
    answer
  end

  def yes_or_no
    answer = nil
    loop do
      input = gets.chomp.downcase
      break answer = input if %w(y n yes no).include?(input)
      puts "Invalid input.\nType 'y' or 'n' please."
    end
    answer[0]
  end
end

module Displayable
  def clear_screen
    system 'clear' || 'cls'
  end

  def display_welcome_message
    puts "Welcome to 21! The game where Everyone's a winner!"
  end

  def display_busted(player)
    puts "#{player} has busted!"
  end

  def display_results(winners, losers, tiers)
    display_winners(winners) if winners.size > 0
    display_losers(losers) if losers.size > 0
    display_tiers(tiers) if tiers.size > 0
  end

  def display_winners(winners)
    case winners.size
    when 1
      puts "#{winners.first} wins!"
    when 2
      puts "#{winners.join(' and ')} win!"
    else
      puts "#{winners[0..-2].join(', ')} and #{winners.last} win!"
    end
  end

  def display_losers(losers)
    case losers.size
    when 1
      puts "#{losers.first} lost."
    when 2
      puts "#{losers.join(' and ')} lost."
    else
      puts "#{losers[0..-2].join(', ')} and #{losers.last} lost."
    end
  end

  def display_tiers(tiers)
    case tiers.size
    when 1
      puts "#{tiers.first} tied with dealer."
    when 2
      puts "#{tiers.join(' and ')} tied with dealer."
    else
      puts "#{tiers[0..-2].join(', ')} and #{tiers.last} tied with dealer."
    end 
  end

  def display_goodbye_message
    puts "Thanks for playing! Stay warm out there #{players.first}"
  end
end

class Deck
  attr_reader :deck

  SUITS = %w(♥ ♤ ♧ ♦).freeze
  RANKS = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'].freeze

  def initialize
    @deck = []
    reset
  end

  def reset
    SUITS.each do |suit|
      RANKS.each do |rank|
        deck << Card.new(rank, suit)
      end
    end
  end

  def shuffle!
    deck.shuffle!
  end

  def draw
    deck.pop
  end

  def empty?
    deck.empty?
  end
end

class Card
  attr_reader :suit, :rank

  def initialize(rank, suit)
    @suit = suit
    @rank = rank
  end

  def to_s
    puts image
    ''
  end

  def image
    [ '  _________  ',
      " |       #{rank.to_s.rjust(2)}| ",
      ' |         | ',
      " |    #{suit}    | ",
      ' |         | ',
      " |#{rank.to_s.rjust(2)}       | ",
      ' |_________| ', '' ]
  end
end

class Player
  attr_accessor :hand, :name

  def initialize
    @name = get_name
    @hand = []
  end

  def hit?(move)
    move == 'h'
  end

  def stay?(move)
    move == 's'
  end

  def busted?
    evaluate_hand > 21
  end
  
  def toss_cards
    self.hand = []
  end

  def to_s
    name
  end

  def get_name
    loop do
      puts "Please enter your name."
      input = gets.chomp
      break self.name = input if !input.strip.empty?
      puts "Invalid name."
    end
  end

  def card_values
    hand.map do |card|
      case card.rank
      when 'A'
        11
      when 'J', 'Q', 'K'
        10
      else
        card.rank
      end
    end
  end

  def count_aces
    hand.count { |card| card.rank == 'A' }
  end
  
  def evaluate_hand
    aces = count_aces
    total = card_values.sum
    until total <= 21 || aces == 0
      total -= 10
      aces -= 1
    end
    total
  end
end

class Computer < Player
  NAMES = %w( Max Calvin Pietro Sam Shiela Denise Carol Jenny
              Belladonna Cleopatra Carl )

  private

  def get_name
    NAMES.sample
  end

end

class Dealer < Player
  NAMES = %w( James Arthur Taylor John
              Sally Kim Carry Jessie Chrissa
              Clamtrop Claptrap Rose Dorothy Sophia Blanche)

  attr_accessor :deck

  def initialize
    super
    @deck = Deck.new
    deck.shuffle!
  end

  def get_name
    NAMES.sample
  end

  def deal(player, num_cards)
    num_cards.times do
      restock if deck.empty?
      player.hand << deck.draw
    end
  end

  def restock
    deck.reset
    deck.shuffle!
  end
end

class Score; end

class Game
  include Validatable, Displayable
  
  def initialize
    @players = []
    @dealer = Dealer.new
    @score = Score.new
  end
  
  def play
    display_welcome_message
    set_players
    main_game
    display_goodbye_message
  end

  private

  attr_accessor :players, :dealer, :score, :first_show

  def main_game
    loop do
      reset
      initial_deal
      show_cards
      player_turns
      dealer_turn
      determine_winners #also adds to scores
      break unless play_again?
    end
  end

  def play_again?
    puts "Would you like to play again? (y/n)"
    answer = yes_or_no
    answer == 'y'
  end

  def determine_winners
    winners = players_won
    losers = players_lost
    tiers = players_tied
    display_results(winners, losers, tiers)
    puts "The House Wins..." if losers.size == players.size
  end

  def players_won
    players.select do |player|
      dealer.busted? && !player.busted? ||
      player.evaluate_hand > dealer.evaluate_hand &&
      !player.busted?
    end.map(&:name)
  end

  def players_lost
    players.select do |player|
      player.busted? ||
      player.evaluate_hand < dealer.evaluate_hand && !dealer.busted?
    end.map(&:name)
  end

  def players_tied
    players.select do |player|
      !player.busted? && player.evaluate_hand == dealer.evaluate_hand
    end.map(&:name)
  end

  def show_cards
    clear_screen
    show_dealer_cards
    show_player_cards
  end

  def reset
    dealer.toss_cards
    players.each(&:toss_cards)
    self.first_show = true
  end

  def show_dealer_cards
    if @first_show
      puts "Dealer: #{dealer.name}--Score: #{dealer.card_values.first}"
      puts prep_card_display([dealer.hand.first, Card.new('?', '?')])
    else
      puts "Dealer: #{dealer.name}--Score: #{dealer.evaluate_hand}"
      puts prep_card_display(dealer.hand)
    end
  end

  def show_player_cards
    players.each_with_object({}) do |player, output|
      output[player] = prep_card_display(player.hand)
    end.each do |player, cards|
      puts "Player: #{player}--Score: #{player.evaluate_hand}"
      puts cards
      puts ''
    end
  end

  def prep_card_display(hand)
    hand.map(&:image).transpose.map(&:join)
  end

  def player_turns
    players.each do |player|
      decide(player)
      display_busted(player) if player.busted?
    end
    self.first_show = false if first_show
  end

  def decide(player)
    if player.is_a? Computer
      computer_decide(player)
    else
      player_decide(player)
    end
  end

  def player_decide(player)
    loop do
      puts "#{player}'s turn."
      move = hit_or_stay
      dealer.deal(player, 1) if player.hit?(move)
      show_cards
      break if player.stay?(move) || player.busted?
    end
  end

  def computer_decide(player)
    until player.evaluate_hand >= 17 ||
          player.busted?
      dealer.deal(player, 1)
    end
    show_cards
  end

  def dealer_turn
    unless players.all?(&:busted?)
      until dealer.evaluate_hand >= 17 || dealer.busted?
        dealer.deal(dealer, 1)
      end
    end
    show_cards
  end


  def set_humans
    humans = nil
    loop do
      puts "How many humans will be playing today?"
      input = gets.chomp
      if is_number?(input) && input.to_i >= 0
        break humans = input.to_i
      end
      puts "Please input a number greater than or equal to 0"
    end
    humans
  end

  def set_computers
    computers = nil
    loop do
      puts "Will there be any additional automated players today?"
      input = gets.chomp
      if is_number?(input) && input.to_i >= 0
        break computers = input.to_i
      end
      puts "Please input a number greater than or equal to 0"
    end
    computers
  end

  def set_players
    humans = set_humans
    computers = set_computers
    if humans + computers == 0
      puts "We need at least one player to play."
      set_players
    end
    humans.times { |human| players << Player.new }
    computers.times { |computer| players << Computer.new }
  end

  def initial_deal
    participants = players + [dealer]
    participants.each do |player|
      dealer.deal(player, 2)
    end
  end
end

twenty_one = Game.new
twenty_one.play