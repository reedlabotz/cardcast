class PlayerWelcomeCtrl
  @inject: ['$scope', '$location', 'chromecast']
  constructor: (@$scope, @$location, @chromecast) ->
    @$scope.openGame = (gameId) =>
      @$location.path '/game/' + gameId
    @$scope.startChromecast = () =>
      @$scope.loadingMessage = "Connecting to chromecast"
      @chromecast.connect () =>
        @$scope.$apply () =>
          @$scope.loadingMessage = undefined

