class PlayerCtrl
  @$inject: ['$scope', 'chromecast']
  constructor: (@$scope, @chromecast) ->
    @chromecast.connect () ->
