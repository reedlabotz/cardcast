class HouseCtrl
  @$inject: ['$scope', 'chromecast']
  constructor: (@$scope, @chromecast) ->
    $scope.loading = true
    @chromecast.initializeReceiver () =>
      possible = "ABCDEFGHJKLMNPQRSTUVWXYZ123456789"
      peerId = ""
      for i in [0..4]
        peerId += possible.charAt Math.floor (Math.random() * possible.length)
      @peer = new Peer peerId, {key: 'z5y7lsci3p4lsor'}
      @peer.on 'open', () =>
        @$scope.$apply () =>
          $scope.id = @peer.id
          @$scope.loading = false
