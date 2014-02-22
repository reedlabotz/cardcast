#<< cardcast/util/deck

class HeartsHouseModel
  constructor: (@players) ->

  ready: () ->
    return @players.length == 4

  startGame: () ->
    deal()

  deal: () ->
    deck = new DeckModel [0..51]
    deck.shuffle()
    hands = deck.deal [13, 13, 13, 13]    
