#<< cardcast/model/player
#<< cardcast/model/house

class HouseCtrl
  @$inject: ['$scope', 'chromecast', 'peer', 'housemodel']
  constructor: (@$scope, @chromecast, @peer, @model) ->
    # Setup the basic scope
    @$scope.model = @model
    # Start the app
    @statusChange()
    @chromecast.initializeReceiver () => @setupHost()

  setupHost: () ->
    @peer.start {
      onOpen: () => @model.peerOnOpen(),
      onConnection: (conn) => @model.peerOnConnection(conn)
    }, @model.getGameId()

  statusChange: () ->
    switch @model.status
      when HouseModel.Status.LOADING
        console.log 'in loading state'
        @$scope.loadingMessage = 'Loading...'
        @$scope.templateUrl = 'templates/house/welcome.tpl.html'
      when HouseModel.Status.WAITING_FOR_PLAYERS
        console.log 'in waiting state'
        @$scope.loadingMessage = 'Loading...'
        @$scope.templateUrl = 'templates/house/welcome.tpl.html'
