#<< cardcast/player_controller
#<< cardcast/house_controller
#<< cardcast/service/chromecast
#<< cardcast/service/peer

CHROMECAST_API_KEY = '17F0F24F'
PEERJS_API_KEY = 'z5y7lsci3p4lsor'

app = angular.module 'app', ['ngRoute', 'templates.app']

###
Controllers
###
app.controller 'PlayerCtrl', PlayerCtrl
app.controller 'HouseCtrl', HouseCtrl

###
Services
###
app.service 'chromecast', () -> new ChromecastService CHROMECAST_API_KEY
app.service 'peer', () -> new PeerService PEERJS_API_KEY
