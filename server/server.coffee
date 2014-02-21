io = require('socket.io').listen(8023)

games = {}
class Player
  constructor: (@id, @socket, @game) ->
    @replaceSocket @socket

  replaceSocket: (@socket) ->
    # setup listeners and send status update to house
    @socket.on 'msg', (data) =>
      @game.sendHouseMessage @id, data
    @socket.on 'disconnect', () =>
      @game.sendPlayerUpdate @id, 'dead'
    @game.sendPlayerUpdate @id, 'alive'

  sendMessage: (data) ->
    @socket.emit 'msg', data    

  
class Game
  constructor: (@id, @house) ->
    @players = {}
    @replaceSocket @house

  replaceSocket: (@house) ->
    @house.on 'msg', (data) =>
      @players[data.to].sendMessage data.payload
    @house.on 'disconnect', () =>
      console.log 'house disconnected', @id

  join: (player, socket) ->
    if @players[player.id]?
      @players[player.id].replaceSocket socket
    else
      @sendPlayerUpdate player.id, 'new', player
      @players[player.id] = new Player player.id, socket, @


  sendHouseMessage: (from, data) ->
    @house.emit 'msg', {from: from, payload: data}

  sendPlayerUpdate: (from, type, payload) ->
    @house.emit 'player', {from: from, type: type, payload: payload}
    
  houseMsg: (data) ->


registerGame = (id, houseSocket) ->
  if games[id]?
    game[id].replaceSocket houseSocket
    return
  game = new Game id, houseSocket
  games[id] = game
    
io.sockets.on 'connection', (socket) ->
  socket.on 'register', (data) ->
    registerGame data.id, socket
  socket.on 'join', (data) ->
    if games[data.id]
      games[data.id].join data.player, socket
    else
      socket.emit 'msg', { type: -1, data: 'Game does not exist'}
