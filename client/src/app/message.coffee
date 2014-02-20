class Message
  @types = {
    PLAYER_DATA: 1,
    GAME_STATUS_UPDATE: 2
  }
  constructor: (@type, @data) ->
