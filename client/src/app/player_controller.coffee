#<< cardcast/message

class PlayerCtrl
  @$inject: ['$scope', '$location', 'chromecast', 'peer', '$route']
  constructor: (@$scope, @$location, @chromecast, @peer) ->
    @gameId = @$location.path().substring(1).toUpperCase()
    return @welcomeScreen() if @gameId.length < 5
    @$scope.loadingMessage = "Loading..."
    @peer.start({
      onOpen: () => @peerOnOpen()
    })
    @setupClickHandlers()

  welcomeScreen: () ->
    @$scope.openGame = (gameId) =>
      window.location = "/#" + gameId
      window.location.reload()
    @$scope.startChromecast = () =>
      @$scope.loadingMessage = "Connecting to chromecast"
      @chromecast.connect () =>
        @$scope.$apply () =>
          @$scope.loadingMessage = undefined
    @$scope.templateUrl = 'templates/player/welcome.tpl.html'

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
    
