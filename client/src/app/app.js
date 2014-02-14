angular.module('app', [
    'ngRoute',
    'game',
    'templates.app']);

angular.module('app').config(['$routeProvider', function ($routeProvider) {
}]);

function initializeCastApi() {
    console.log("init cast api");
    if (!chrome.cast || !chrome.cast.isAvailable) {
        console.log("cast not ready");
        setTimeout(initializeCastApi, 1000);
        return;
    }

    var sessionRequest = new chrome.cast.SessionRequest('17F0F24F');
    var apiConfig = new chrome.cast.ApiConfig(sessionRequest,
                                              function(s) {
                                                  console.log("session listener", s);
                                              },
                                              function(r) {
                                                  console.log("receiver listener", r);
                                                  chrome.cast.requestSession(function(s) {
                                                      console.log("request session sucess", s);
                                                      var message = prompt("Message");
                                                      s.sendMessage('urn:x-cast:com.reedlabotz.cards', message);
                                                  }, function(e) {
                                                      console.log("request session error", e);
                                                  });
                                              });
    chrome.cast.initialize(apiConfig, function() {
        console.log("init sucess");
    }, function(e) {
        console.log("init error", e);
    });
};

angular.module('app').controller('AppCtrl', ['$scope', function($scope) {
    initializeCastApi();
}]);