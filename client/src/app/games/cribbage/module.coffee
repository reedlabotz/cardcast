#<< cardcast/shared/directives/module
#<< cardcast/games/cribbage/house/controller
#<< cardcast/games/cribbage/player/controller


cribbage = angular.module 'cardcast.games.cribbage', [
  'cardcast.shared.directives']

cribbage.controller 'CribbageHouseCtrl', CribbageHouseCtrl
cribbage.controller 'CribbagePlayerCtrl', CribbagePlayerCtrl

cribbage.config ['$routeProvider', ($routeProvider) ->
  $routeProvider.when '/house/cribbage', {
    templateUrl: 'house/main.tpl.html',
    controller: 'CribbageHouseCtrl'
  }
  $routeProvider.when '/game/cribbage/:gameId', {
    templateUrl: 'player/main.tpl.html',
    controller: 'CribbagePlayerCtrl'
  }
]
