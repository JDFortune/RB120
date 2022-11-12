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
  shuffle
  deal

Cards
  display (to_s)

Player
  Hit/Stay (encompassed under a 'turn' or 'move' method)
   - hand will need to be evaluated after each hit

Dealer (Does this class inherit player? I think so)


Hand (collaborator of Player? or a state of the player?)
  evaluate/calculate_total
  bust is a state associated with the current hand

Game
  playgame
