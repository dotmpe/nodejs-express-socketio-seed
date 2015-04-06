# jrc:import ../../ng ../services ../directives/navMenu
( app ) ->

  console.log(' Home controllers Coffee-Script', app )

  app.register.controller 'HomeCtrl', ($scope, socket) ->

    $scope.message = "Message from HomeCtrl"

    socket.on 'connection', ->
      console.log 'connection xxxx', arguments
    socket.on 'ping', (ts) ->
      console.log 'revc ping', ts

    socket.on 'send:name', (data) ->
      console.log 'revc send:name'
      $scope.name = data.name

    socket.on 'send:time', (data) ->
      console.log 'revc send:time'
      $scope.time = data.time



