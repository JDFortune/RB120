class Deck
  SUITS = %w(Hearts Clubs Spades Diamonds).freeze
  RANKS = (2..10).to_a + %w(Jack Queen King Ace).freeze

  def initialize
    @master_deck = create_deck
    install_deck
  end
  
  def draw
    if deck.empty?
      install_deck
      puts "New deck being installed"
    end
    deck.pop 
  end

  def see_deck
    deck.dup
  end

  private
  
  attr_accessor :deck

  def install_deck
    self.deck = @master_deck.dup.shuffle
  end

  def create_deck
    temp = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        temp << Card.new(rank, suit)
      end
    end
    temp
  end
end

class Card < Deck
  include Comparable
  attr_reader :rank, :suit

  VALUES = {'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14}
  SUITS = { 'Spades' => 4, 'Hearts' => 3, 'Clubs' => 2, 'Diamonds' => 1 }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def <=>(other)
    if value == other.value
      SUITS[suit] <=> SUITS[other.suit]
    else
      value <=> other.value
    end
  end

  def value
    VALUES.fetch(rank, rank)
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

class PokerHand < Deck
  ROYALS = [10, 'Jack', 'Queen', 'King', 'Ace']

  def initialize(deck)
    @hand = []
    5.times { hand << deck.draw }
  end

  def print
    puts hand
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private
  attr_accessor :hand
  
  def royal_flush?
    hand.all? do |card|
      hand.count { |cur| cur.suit == card.suit } == 5 &&
      ROYALS.include?(card.rank)
    end
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    hand.any? do |card|
      hand.count { |curr| curr.rank == card.rank } == 4
    end
  end

  def full_house?
    hand.all? do |card|
      hand.count { |cur| cur.rank == card.rank } == 2 ||
      hand.count { |cur| cur.rank == card.rank } == 3
    end
  end

  def flush?
    hand.all? do |card|
      hand.count { |curr| curr.suit == card.suit } == 5
    end
  end

  def straight?
    straights = get_straights
    straights.one? do |rank_subs|
      rank_subs.all? do |rank_test|
        hand.count { |card| card.rank == rank_test } == 1
      end
    end
  end

  def three_of_a_kind?
    hand.any? do |card|
      hand.count { |curr| curr.rank == card.rank } == 3
    end
  end

  def two_pair?
    hand.select do |card|
      hand.count { |curr| curr.rank == card.rank } == 2
    end.size == 4
  end

  def pair?
    hand.any? do |card|
      hand.count { |curr| curr.rank == card.rank } == 2
    end
  end

  def get_straights
    straights = []
    (0..RANKS.size - 5).each do |idx|
      straights << RANKS[idx, 5]
    end
    straights
  end
end

hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'