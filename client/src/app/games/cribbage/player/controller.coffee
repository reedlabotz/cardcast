#<< cardcast/player/controller

class CribbagePlayerCtrl extends PlayerCtrl
  init: () ->
    @socketio.on 'msg', (data) => @message(data)

  message: (data) ->
    console.log data
  
