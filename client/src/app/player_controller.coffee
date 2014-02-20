#<< cardcast/message

class PlayerCtrl
  @$inject: ['$scope', '$location', '$routeParams', 'peer', 'googleplus']
  constructor: (@$scope, @$location, @$routeParams, @peer, @googleplus) ->
    @gameId = @$routeParams.gameId
    @$scope.loadingMessage = "Loading..."
    @peer.start({
      onOpen: () => @peerOnOpen()
    })
    @setupClickHandlers()

  peerOnOpen: () ->
    @conn = @peer.connect @gameId, {
      onOpen: () => @connectionOnOpen()
      onData: () => @connectionOnData()
    }

  setupClickHandlers: () ->
    @$scope.sendName = (name) => @sendName(name)

  connectionOnOpen: () ->
    console.log 'connection open'
    @$scope.$apply () =>
      @$scope.templateUrl = 'templates/player/login.tpl.html'
      @googleplus.addButton 'signinButton', 'signinCallback', (userData) => @signedIn(userData)
      @$scope.loadingMessage = undefined
    
  connectionOnData: (data) ->
    console.log data

  signedIn: (userData) ->
    @playerData = userData    
    @$scope.loadingMessage = "Waiting for game to start"
    @$scope.templateUrl = undefined

    message = new Message Message.types.PLAYER_DATA, @playerData
    @conn.send(message)
    
