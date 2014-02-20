#<< cardcast/model/player

class HouseModel
  @Status = {
    LOADING: 1,
    CONNECTING: 2,
    WAITING_FOR_PLAYERS: 3,
  }

  constructor: () ->
    @connections = []
    @players = []
    @conn
    @gameId
    @status = HouseModel.Status.LOADING

  getGameId: () ->
    if !@gameId?
      possible = 'ABCDEFGHJKLMNPQRSTUVWXYZ123456789'
      @gameId = ''
      for i in [0..4]
        @gameId += possible.charAt Math.floor (Math.random() * possible.length)
    return @gameId

  peerOnOpen: () ->
    console.log 'peer opened'
    @status = HouseModel.Status.WAITING_FOR_PLAYERS

  peerOnConnection: (conn) ->
    player = new PlayerModel conn
    player.setReadyCallback (player) => @playerReady player
    @connections.push player

  playerReady: (player) ->
    for p in @players
      if player.id == p.id
        p.replace player
        return
    @players.push player

