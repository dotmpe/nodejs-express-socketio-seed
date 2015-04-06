#jrc:import angularAMD
(angularAMD) ->

  console.log 'define dotmpe-project-ng.controllers'

  angular.module 'dotmpe-project-ng.controllers', []

    .controller 'AppCtrl', ($scope, socket) ->
      socket.on 'send:name', (data) ->
        $scope.name = data.name

    .controller 'MyCtrl1', ($scope, socket) ->
      socket.on 'send:time', (data) ->
        $scope.time = data.time

    .controller 'MyCtrl2', ($scope, socket) ->
      null


