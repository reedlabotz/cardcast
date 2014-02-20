#<< cardcast/message

class PlayerModel
  constructor: (@conn) ->
    @conn.setHandler @
    @id;
    @name
    @pic;
    @_readyCallback

  setReadyCallback: (@_readyCallback) ->

  onData: (message) ->
    switch message.type
      when Message.types.PLAYER_DATA
        @name = message.data.name
        @id = message.data.id
        @pic = message.data.pic
        @_readyCallback?(@)

  replace: (player) ->
    @conn = player.conn
    @conn.setHandler @
