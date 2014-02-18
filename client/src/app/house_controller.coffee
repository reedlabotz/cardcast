#<< cardcast/player

class HouseCtrl
  @$inject: ['$scope', 'chromecast', 'peer']
  constructor: (@$scope, @chromecast, @peer) ->
    @$scope.loading = true
    @$scope.players = []

    @chromecast.initializeReceiver () => @setupHost()

  setupHost: () ->
    possible = "ABCDEFGHJKLMNPQRSTUVWXYZ123456789"
    peerId = ""
    for i in [0..4]
      peerId += possible.charAt Math.floor (Math.random() * possible.length)

    @$scope.$on 'playerChange', () => @checkReady()
    @peer.start {
      onOpen: () => @peerOnOpen(),
      onConnection: (conn) => @peerOnConnection(conn)
    }, peerId

  peerOnOpen: () ->
    @$scope.$apply () =>
      @$scope.id = @peer.getId()
      @$scope.loading = false

  peerOnConnection: (conn) ->
    player = new Player @$scope, conn
    @$scope.$apply () =>
      @$scope.players.push player

  checkReady: () ->
    console.log 'check ready', @$scope.players, (p for p in @$scope.players when p.ready())
