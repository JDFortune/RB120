# Twenty One Spike

Dealer Deals out two cards to each player from the deck. and then two to themselves, with the second card face down.
After the cards have been dealt, each player will get a chance to hit until they stay or until they bust. After that point, the dealer, following specific rules will turn over their second card. If it is under 17, they will continue to hit until they are at or over 17 (or bust). If no one busts, then the cards are evaluated and the highest hand wins
  - A bust is considered a score over 21. 21 is the highest value, therefore a 21 wins.


## Nouns
Deck
Cards
Hand
Players
 Dealer
 Human
 (Do we want computer players? perhaps set up game to input player into an array of players at the table. That way, we can easily add a feature for computer players)
Game

## Verbs
Shuffle
Deal
Hit
Stay
Bust
Evalute_Cards(or calculate_total)

## Structure
Deck
  + @deck
  - shuffle
  - deal

Cards
  + @suit, @rank
  - display (to_s)

Player
  + @hand = []
  - Hit
  - Stay
  - busted?
  - evaluate_total

<!-- Add a Computer class that inherits from Player if wanting more functionality -->

Dealer < Player
  + deck
  - deal

Game
  - play
