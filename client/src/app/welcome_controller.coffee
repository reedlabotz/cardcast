class WelcomeCtrl
  @inject: ['$scope', '$location']
  constructor: (@$scope, @$location) ->
    @$scope.openGame = (gameId) =>
      @$location.path '/game/' + gameId
    @$scope.startChromecast = () =>
      @$scope.loadingMessage = "Connecting to chromecast"
      @chromecast.connect () =>
        @$scope.$apply () =>
          @$scope.loadingMessage = undefined

