#<< cardcast/message

class Player
  constructor: (@$scope, @conn) ->
    @conn.setHandler @
    @id;
    @name
    @pic;

  onData: (message) ->
    switch message.type
      when Message.types.PLAYER_DATA
        @name = message.data.name
        @id = message.data.id
        @pic = message.data.pic
        @$scope.$apply () =>
          @$scope.players.push @
