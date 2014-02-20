#<< cardcast/message

class PlayerCtrl
  @$inject: ['$scope', '$location', '$routeParams', 'peer', 'googleplus']
  constructor: (@$scope, @$location, @$routeParams, @peer, @googleplus) ->
    @gameId = @$routeParams.gameId.toUpperCase()
    @$scope.loadingMessage = "Loading..."
    @peer.start({
      onOpen: () => @peerOnOpen()
    })

  peerOnOpen: () ->
    @conn = @peer.connect @gameId, {
      onOpen: () => @connectionOnOpen()
      onData: () => @connectionOnData()
    }

  connectionOnOpen: () ->
    @$scope.templateUrl = 'templates/player/login.tpl.html'
    @googleplus.addButton 'signinButton', 'signinCallback', (userData) => @signedIn(userData)
    @$scope.loadingMessage = undefined
    
  connectionOnData: (data) ->
    console.log data

  signedIn: (userData) ->
    @playerData = userData
    @$scope.$apply () =>
      @$scope.loadingMessage = "Waiting for game to start"
      @$scope.templateUrl = undefined

    message = new Message Message.types.PLAYER_DATA, @playerData
    @conn.send(message)
    
