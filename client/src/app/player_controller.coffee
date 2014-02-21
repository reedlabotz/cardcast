#<< cardcast/message

class PlayerCtrl
  @$inject: ['$scope', '$location', '$routeParams', 'socketio', 'googleplus']
  constructor: (@$scope, @$location, @$routeParams, @socketio, @googleplus) ->
    @gameId = @$routeParams.gameId.toUpperCase()
    @$scope.templateUrl = 'templates/player/login.tpl.html'
    @googleplus.addButton 'signinButton', 'signinCallback', (userData) => @signedIn(userData)
    
  signedIn: (userData) ->
    @playerData = userData
    @$scope.$apply () =>
      @$scope.loadingMessage = "Waiting for game to start"
      @$scope.templateUrl = undefined

    @socketio.start () =>
      @socketio.emit 'join', {id: @gameId, player: @playerData}    
