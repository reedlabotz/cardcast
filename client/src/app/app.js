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
    $scope.link = "Loading...";
    chromecast.initializeReceiver(function() {
        var peerId = "";
        var possible = "ABCDEFGHJKLMNPQRSTUVWXYZ0123456789";
        for( var i=0; i < 5; i++ ) {
            peerId += possible.charAt(Math.floor(Math.random() * possible.length));
        }
        var peer = new Peer(peerId, {key: 'z5y7lsci3p4lsor'});
        peer.on('open', function() {
            $scope.$apply(function() {
                $scope.link = "http://cards.reedlabotz.com/#" + peer.id;
            });
        });
    });
}]);