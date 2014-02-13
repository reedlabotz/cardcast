angular.module('game', [])
    .config(['$routeProvider', function($routeProvider) {
        $routeProvider.when('/game/:Id', {
            templateUrl: 'game/game.tpl.html',
            controller: 'GameCtrl'
        });
    }])
    .controller('GameCtrl', ['$scope', '$location', '$routeParams', function($scope, $location, $routeParams) {
    }]);
