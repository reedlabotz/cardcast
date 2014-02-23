class PlayerModel
  constructor: (data, @socketio) ->
    @id = data.id
    @name = data.name
    @pic = data.pic
    @dead = false

  message: (message) ->

  sendMessage: (data) ->
    @socketio.emit 'msg', {'to': @id, 'payload': data}

  setDead: (value) ->
    @dead = value
