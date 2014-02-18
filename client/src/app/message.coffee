class Message
  @types = {
    NAME_CHANGE: 0,
    GAME_STATUS_UPDATE: 1
  }
  constructor: (@type, @data) ->
