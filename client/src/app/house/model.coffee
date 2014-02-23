#<< cardcast/house/player_model

class HouseModel
  constructor: () ->
    @players = []
    @gameId

  init: (@socketio, @$scope) ->
    @socketio.on 'player', (data) =>
      @$scope.$emit 'playerUpdate'
      @playerUpdate(data)
    @socketio.on 'msg', (data) => @message(data)

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
        @players.push new PlayerModel data.payload, @socketio
      when 'dead'
        player = @getPlayer data.from
        player.setDead true
      when 'alive'
        player = @getPlayer data.from
        player.setDead false

  message: (data) ->
    player = @getPlayer data.from
    player.message data.payload

