#<< cardcast/message

class Player
  constructor: (@$scope, @conn) ->
    @conn.setHandler @

  ready: () ->
    @name?

  onData: (message) ->
    switch message.type
      when Message.types.NAME_CHANGE
        @$scope.$apply () =>
          @name = message.data
          @$scope.$emit 'playerChange'


