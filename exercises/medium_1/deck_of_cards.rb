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
    deck.delete(deck.sample)  
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

class Card
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

deck = Deck.new

puts deck.see_deck

# drawn = []

# 52.times { drawn << deck.draw }

# puts drawn.shuffle!.shuffle!
# p drawn.count {|card| card.rank == 5 }
# p drawn.count {|card| card.suit == 'Hearts' }


# drawn2 = []
# 52.times { drawn2 << deck.draw }

# p drawn2.count {|card| card.rank == 5 }
# p drawn2.count {|card| card.suit == 'Hearts' }

# p drawn2 != drawn
