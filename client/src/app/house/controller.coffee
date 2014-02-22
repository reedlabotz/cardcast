#<< cardcast/house/model

class HouseCtrl
  @$inject: ['$scope', 'chromecast', 'socketio', 'housemodel']
  constructor: (@$scope, @chromecast, @socketio, @model) ->
    # Setup the basic scope
    @$scope.model = @model
    # Start the app
    @statusChange()
    @chromecast.initializeReceiver () => @setupHost()

  setupHost: () ->
    @socketio.start () =>
      @socketio.emit 'register', {id: @model.getGameId()}
      @socketio.on 'player', (data) => @model.playerUpdate(data)
      @socketio.on 'msg', (data) => @model.message(data)
  
  statusChange: () ->
    switch @model.status
      when HouseModel.Status.LOADING
        console.log 'in loading state'
        @$scope.templateUrl = 'house/welcome.tpl.html'
      when HouseModel.Status.WAITING_FOR_PLAYERS
        console.log 'in waiting state'
        @$scope.templateUrl = 'house/welcome.tpl.html'
