class PeerService
  constructor: (@$rootScope, @apiKey) ->

  start: (@handler, @peerId) ->
    @peer = new Peer @peerId, {key: @apiKey}
    @on 'open', (id) => @onOpen(id)
    @on 'connection', (conn) => @handler.onConnection?(new PeerConnection(@$rootScope, conn))
    @on 'close', () => @handler.onClose?()
    @on 'error', (err) => @handler.onError?(err)

  on: (eventName, callback) ->
    @peer.on eventName, () =>
      args = arguments
      @$rootScope.$apply () =>
        callback.apply(@peer, args)

  getId: () ->
    @peerId

  onOpen: (@peerId) ->
    @handler.onOpen?(@peerId)

  connect: (id, connectionHandler) ->
    console.log 'starting new connection', id
    new PeerConnection @$rootScope, @peer.connect(id, {'serialization': 'json'}), connectionHandler

class PeerConnection
  constructor: (@$rootScope, @conn, @handler) ->
    @on 'open', () => @handler.onOpen?() if @handler
    @on 'data', (data) => @handler.onData?(data) if @handler
    @on 'close', () => @handler.onClose?() if @handler
    @on 'error', (err) => @handler.onError?(err) if @handler

  on: (eventName, callback) ->
    @conn.on eventName, () =>
      args = arguments
      @$rootScope.$apply () =>
        callback.apply(@conn, args)

  setHandler: (@handler) ->

  getPeerId: () -> @conn.peer

  send: (data) ->
    console.log 'sending messages to ' + @getPeerId(), data
    @conn.send(data)
    
