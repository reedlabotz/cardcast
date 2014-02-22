class DeckModel
  constructor: (@cards) ->

  shuffle: () ->
    for i in [0..6]
      for card,j in @cards
        k = Math.floor(Math.random() * @cards.length)
        temp = @cards[j];
        @cards[j] = @cards[k];
        @cards[k] = temp;

  deal: (handSizes) ->
    hands = []
    for s in handSizes
      hand = []
      for i in [1..s]
        hand.push @cards.pop()
      hands.push hand
    return hands
