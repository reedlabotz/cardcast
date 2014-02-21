#<< cardcast/model/player

class HouseModel
  @Status = {
    LOADING: 1,
    CONNECTING: 2,
    WAITING_FOR_PLAYERS: 3,
  }

  constructor: () ->
    @players = []
    @gameId
    @status = HouseModel.Status.LOADING

  getGameId: () ->
    if !@gameId?
      possible = 'ABCDEFGHJKLMNPQRSTUVWXYZ123456789'
      @gameId = ''
      for i in [0..4]
        @gameId += possible.charAt Math.floor (Math.random() * possible.length)
    return @gameId

  getPlayer: (id) ->
    for p in @players
      if p.id == id
        return p
    return undefined

  playerUpdate: (data) ->
    switch data.type
      when 'new'
        @players.push new PlayerModel data.payload
      when 'dead'
        player = @getPlayer data.from
        player.setDead true
      when 'alive'
        player = @getPlayer data.from
        player.setDead false

  message: (data) ->
    player = @getPlayer data.from
    player.message data.payload

