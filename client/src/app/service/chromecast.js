angular.module('app').factory('chromecast',function() {
    var session;
    var receiverListener = function(callback) {
        chrome.cast.requestSession(function(s) {
            session = s;
            callback();
        }, function(e) {
            console.log("request session error", e);
        });
        
    };
    var initializeCastApi = function(callback) {
        if (!chrome.cast || !chrome.cast.isAvailable) {
            console.log("cast not ready");
            setTimeout(function() {
                initializeCastApi(callback);
            }, 200);
            return;
        }
        
        var sessionRequest = new chrome.cast.SessionRequest('17F0F24F');
        var apiConfig = new chrome.cast.ApiConfig(sessionRequest,
                                                  function(s) {},
                                                  function(r) {
                                                      receiverListener(callback);
                                                  });
        chrome.cast.initialize(apiConfig, function() {
            console.log("init sucess");
        }, function(e) {
            console.log("init error", e);
        });
    }; 
    
    var chromecastService = {
        connect: function(callback) {
            initializeCastApi(callback);
        },
        sendMessage: function(message) {
            session.sendMessage('urn:x-cast:com.reedlabotz.cards', message);
        }
    };
    return chromecastService;
});