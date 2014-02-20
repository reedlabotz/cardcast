#<< cardcast/app_controller
#<< cardcast/player_controller
#<< cardcast/welcome_controller
#<< cardcast/house_controller
#<< cardcast/service/chromecast
#<< cardcast/service/peer
#<< cardcast/service/googleplus

CHROMECAST_API_KEY = '17F0F24F'
PEERJS_API_KEY = 'z5y7lsci3p4lsor'

app = angular.module 'app', ['ngRoute', 'templates.app']

###
Controllers
###
app.controller 'AppCtrl', AppCtrl
app.controller 'WelcomeCtrl', WelcomeCtrl
app.controller 'PlayerCtrl', PlayerCtrl
app.controller 'HouseCtrl', HouseCtrl

###
Services
###
app.service 'chromecast', () -> new ChromecastService CHROMECAST_API_KEY
app.service 'peer', () -> new PeerService PEERJS_API_KEY
app.service 'googleplus', ['$http', ($http) -> new GooglePlusService $http ]

###
Routes
###
app.config ['$routeProvider', ($routeProvider) ->
  $routeProvider.when '/welcome', {
    templateUrl: 'templates/player/welcome.tpl.html',
    controller: 'WelcomeCtrl'
  }
  $routeProvider.when '/game/:gameId', {
    templateUrl: 'templates/player/main.tpl.html',
    controller: 'PlayerCtrl'
  }
  $routeProvider.when '/house', {
    templateUrl: 'templates/house/main.tpl.html',
    controller: 'HouseCtrl'
  }
  $routeProvider.otherwise {
    redirectTo: '/welcome'
  }
]
