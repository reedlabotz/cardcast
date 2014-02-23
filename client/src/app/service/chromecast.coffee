class ChromecastService
  constructor: (@apiKey) ->
    
  connect: (callback) ->
    @initializeCastApi callback

  initializeReceiver: (callback) ->
    if !cast? || !cast.receiver?
      console.log 'cast not ready'
      setTimeout () =>
        @initializeReceiver callback
      , 500
      return
      
    window.castReceiverManager = cast.receiver.CastReceiverManager.getInstance()
    window.castReceiverManager.start()
    callback()

  noop = () ->
    
  initializeCastApi: (callback) ->
    if !chrome.cast || !chrome.cast.isAvailable
      console.log "cast not ready"
      setTimeout () =>
        @initializeCastApi callback
      , 200

    sessionRequest = new chrome.cast.SessionRequest @apiKey
    apiConfig = new chrome.cast.ApiConfig sessionRequest, noop, () =>
      @receiverListener callback

    chrome.cast.initialize apiConfig, noop, noop

  receiverListener: (callback) ->
    chrome.cast.requestSession (@session) =>
      callback()
    , noop
  
