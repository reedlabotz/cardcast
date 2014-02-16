#<< cardcast/player_controller
#<< cardcast/house_controller
#<< cardcast/service/chromecast
app = angular.module 'app', ['ngRoute', 'templates.app']

###
Controllers
###
app.controller 'PlayerCtrl', PlayerCtrl
app.controller 'HouseCtrl', HouseCtrl

###
Services
###
app.service 'chromecast', () -> new ChromecastService
