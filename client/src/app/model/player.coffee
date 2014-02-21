#<< cardcast/message

class PlayerModel
  constructor: (data) ->
    @id = data.id
    @name = data.name
    @pic = data.pic
    @dead = false

  message: (message) ->

  setDead: (value) ->
    @dead = value
