#<< cardcast/message

class PlayerCtrl
  @$inject: ['$scope', '$location', 'chromecast', 'peer']
  constructor: (@$scope, @$location, @chromecast, @peer) ->
    @gameId = @$location.path().substring(1).toUpperCase()
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
      @$scope.templateUrl = 'templates/player/name.tpl.html'
      @$scope.loadingMessage = undefined
    
  connectionOnData: (data) ->
    console.log data

  sendName: (name) ->
    @$scope.name = name 
    @$scope.loadingMessage = "Waiting for game to start"
    @$scope.templateUrl = undefined

    message = new Message Message.types.NAME_CHANGE, @$scope.name
    @conn.send(message)
    
