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