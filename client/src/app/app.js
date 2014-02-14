angular.module('app', [
    'ngRoute',
    'templates.app']);

angular.module('app').config(['$routeProvider', function ($routeProvider) {
}]);


angular.module('app').controller('AppCtrl', ['$scope','chromecast', function($scope, chromecast) {
    chromecast.connect(function() {
    });
    window.chromecast = chromecast;
}]);

angular.module('app').controller('ReceiverCtrl', ['$scope','chromecast', function($scope, chromecast) {
    $scope.id="Loading...";
    chromecast.initializeReceiver(function() {
        var peer = new Peer({key: 'z5y7lsci3p4lsor'});
        peer.on('open', function() {
            $scope.$apply(function() {
                $scope.id = peer.id;
            });
        });
    });
}]);