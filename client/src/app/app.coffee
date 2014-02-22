#<< cardcast/controller
#<< cardcast/player/controller
#<< cardcast/player/welcome_controller
#<< cardcast/house/controller
#<< cardcast/service/chromecast
#<< cardcast/service/socketio
#<< cardcast/service/googleplus
#<< cardcast/house/model

CHROMECAST_API_KEY = '17F0F24F'
SOCKET_IO_SERVER = "http://cards.reedlabotz.com"

app = angular.module 'app', ['ngRoute', 'templates.app']

###
Controllers
###
app.controller 'AppCtrl', AppCtrl
app.controller 'PlayerWelcomeCtrl', PlayerWelcomeCtrl
app.controller 'PlayerCtrl', PlayerCtrl
app.controller 'HouseCtrl', HouseCtrl

###
Services
###
app.service 'chromecast', () -> new ChromecastService CHROMECAST_API_KEY
app.service 'socketio', ['$rootScope', ($rootScope) -> new SocketIOService $rootScope, SOCKET_IO_SERVER ]
app.service 'googleplus', () -> new GooglePlusService()
app.service 'housemodel', () -> new HouseModel()

###
Routes
###
app.config ['$routeProvider', ($routeProvider) ->
  $routeProvider.when '/welcome', {
    templateUrl: 'player/welcome.tpl.html',
    controller: 'PlayerWelcomeCtrl'
  }
  $routeProvider.when '/game/:gameId', {
    templateUrl: 'player/main.tpl.html',
    controller: 'PlayerCtrl'
  }
  $routeProvider.when '/house', {
    templateUrl: 'house/main.tpl.html',
    controller: 'HouseCtrl'
  }
  $routeProvider.otherwise {
    redirectTo: '/welcome'
  }
]
