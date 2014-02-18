class PeerService
  constructor: (@apiKey) ->

  start: (@handler, @peerId) ->
    @peer = new Peer @peerId, {key: @apiKey}
    @peer.on 'open', (id) => @onOpen(id)
    @peer.on 'connection', (conn) => @handler.onConnection?(new PeerConnection(conn))
    @peer.on 'close', () => @handler.onClose?()
    @peer.on 'error', (err) => @handler.onError?(err)

  getId: () ->
    @peerId

  onOpen: (@peerId) ->
    @handler.onOpen?(@peerId)

  connect: (id, connectionHandler) ->
    console.log 'starting new connection', id
    new PeerConnection @peer.connect(id, {'serialization': 'json'}), connectionHandler

class PeerConnection
  constructor: (@conn, @handler) ->
    @conn.on 'open', () => @handler.onOpen?() if @handler
    @conn.on 'data', (data) => @handler.onData?(data) if @handler
    @conn.on 'close', () => @handler.onClose?() if @handler
    @conn.on 'error', (err) => @handler.onError?(err) if @handler

  setHandler: (@handler) ->

  getPeerId: () -> @conn.peer

  send: (data) ->
    console.log 'sending messages to ' + @getPeerId(), data
    @conn.send(data)
    
