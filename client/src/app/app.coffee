#<< cardcast/player_controller
#<< cardcast/house_controller
#<< cardcast/service/chromecast
app = angular.module 'app', ['ngRoute', 'templates.app']

app.controller 'PlayerCtrl', PlayerCtrl
app.controller 'HouseCtrl', HouseCtrl

app.service 'chromecast', () -> new ChromecastService

