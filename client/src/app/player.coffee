#<< cardcast/message

class Player
  constructor: (@$scope, @conn) ->
    @conn.setHandler @
    @pic = "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-ash3/t1/c0.4.621.621/s320x320/528393_3411170044084_655232213_n.jpg"

  ready: () ->
    @name?

  onData: (message) ->
    switch message.type
      when Message.types.NAME_CHANGE
        @$scope.$apply () =>
          @name = message.data
          @$scope.$emit 'playerChange'


