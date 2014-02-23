#<< cardcast/house/model

class HouseCtrl
  @$inject: ['$scope', 'chromecast', 'socketio', 'housemodel']
  constructor: (@$scope, @chromecast, @socketio, @model) ->
    # Setup the basic scope
    @$scope.model = @model
    @init()

  init: () ->
    # Start the app
    @$scope.templateUrl = 'house/welcome.tpl.html'
    @chromecast.initializeReceiver () => @setupHost()

  setupHost: () ->
    @socketio.start () =>
      @socketio.emit 'register', {id: @model.getGameId()}
      @$scope.model.init @socketio, @$scope
