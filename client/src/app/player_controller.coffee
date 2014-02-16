class PlayerCtrl
  @$inject: ['$scope', '$location', 'chromecast']
  constructor: (@$scope, @$location, @chromecast) ->
    @gameId = @$location.path().substring(1).toUpperCase()
    console.log @gameId
    @peer = new Peer {key: 'z5y7lsci3p4lsor'}
    @peer.on 'open', () =>
      console.log @peer.id
      conn = @peer.connect @gameId
      console.log conn
      conn.on 'open', () =>
        console.log 'connection opened'
      conn.on 'data', (data) =>
        console.log data
      conn.on 'error', (e) =>
        console.log "error", e
      conn.on 'close', () =>
        console.log 'connection closed'
   
