directives = angular.module 'cardcast.shared.directives', []
directives.directive 'player', () ->
  {
    restrict: 'E',
    scope: {
      player: '=player'
    },
    templateUrl: 'shared/directives/player.tpl.html'
  }
