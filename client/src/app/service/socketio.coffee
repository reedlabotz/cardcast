class SocketIOService
  constructor: (@$rootScope, @server) ->

  start: (callback) ->
    @socket = io.connect @server
    @socket.on 'connect', () =>
      callback()

  on: (eventName, callback) ->
    @socket.on eventName, () =>
      args = arguments
      @$rootScope.$apply () =>
        callback.apply(@socket, args)

  emit: (name, data) ->
    @socket.emit name, data


