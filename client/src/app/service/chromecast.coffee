class ChromecastService
  constructor: (@apiKey) ->
    
  connect: (callback) ->
    @initializeCastApi callback

  initializeReceiver: (callback) ->
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
  
