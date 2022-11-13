module Validatable
  def is_number?(num)
    num.match?(/[0-9]/)
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

  def shuffle
    deck.shuffle
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

  private

  def image
    [ '',
      '  _________ ',
      " |       #{rank.to_s.rjust(2)}| ",
      ' |         | ',
      " |    #{suit}    | ",
      ' |         | ',
      " |#{rank.to_s.rjust(2)}       | ",
      ' |_________| ' ]
  end
end

class Player
  attr_accessor :hand, :name
  def initialize
    @name = get_name
    @hand = []
  end

  def hit?

  end

  def stay
  end

  def busted?
    evaluate_hand > 21
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

class Dealer < Player
  NAMES = %w( Henry Ford Barry James John Junior
              Sally Mary-Anne Kim Carry Jessie Chrissa
              Clamtrop Juniper )

  attr_accessor :deck

  def initialize
    super
    @deck = Deck.new
    3.times { deck.shuffle }
  end

  def get_name
    NAMES.sample
  end

  def deal(player, num_cards)
    num_card.times { player.hand << deck.pop }
  end

  def restock
    deck.reset
    deck.shuffle
  end
end

class Game
  include Validatable
  
  def initialize
    @players = []
    @dealer = Dealer.new
    @score = Score.new
  end
  
  def play
    display_welcome_message
    how_many_players
    #main_game
    loop do
      initial_deal
      show_cards
      player_turns
      dealer_turn
      determine_winners #also adds to scores
    end
    determine_winner
    display_goodbye_message
  end

  def player_turns

  end

  def dealer_turn

  end

  def how_many_humans
    humans = nil
    loop do
      puts "How many humans will be playing today?"
      input = gets.chomp
      if input.is_number? && input.to_i >= 0
        break humans = input.to_i
      end
      puts "Please input a number greater than or equal to 0"
    end
    humans
  end

  def how_many_computers
    computers = nil
    loop do
      puts "Will there be any additional automated players today?"
      input = gets.chomp
      if input.is_number? && input.to_i >= 0
        break computers = input.to_i
      end
      puts "Please input a number greater than or equal to 0"
    end
    computers
  end

  def how_many_players
    humans = how_many_humans
    computers = how_many_computers
    humans.times { |human| players << Player.new }
    # need to update player so it get's name
    computers.times { |computer| players << Computer.new }
    # need to add computer class and functionality
  end

  def initial_deal
    players.each do |player|
      dealer.deal(player, 2)
    end
    dealer.deal_self # how do I want to phrase this for their one hidden card.
  end
end



dealer = Dealer.new
puts dealer.deck.deck