#<< cardcast/house/controller

class CribbageHouseCtrl extends HouseCtrl
  init: () ->
    @$scope.$on 'playerUpdate', () => @checkReady()
    super()

  checkReady: () ->
    if @model.players.length == 2
      @startGame()
      

  startGame: () ->
    @$scope.templateUrl = 'games/cribbage/house/main.tpl.html'
    @deal()

  deal: () ->
    deck = new DeckModel [0..51]
    deck.shuffle()
    hands = deck.deal [6, 6]
    console.log 'deal', hands
    @model.players[0].sendMessage {'type': 'deal', 'data': hands[0]}
    @model.players[1].sendMessage {'type': 'deal', 'data': hands[1]}

