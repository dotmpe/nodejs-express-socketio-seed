'use strict'

define [

  'cs!dotmpe-project/app'
  'cs!dotmpe-project/ng-module/services'
  'cs!dotmpe-project/ng-module/directives/navMenu'

], (app) ->

  console.log(' Home controllers Coffee-Script', app )

  app.register.controller 'HomeCtrl', ($scope, socket) ->
    $scope.message = "Message from HomeCtrl"
    socket.on 'send:name', (data) ->
      $scope.name = data.name
    socket.on 'send:time', (data) ->
      $scope.time = data.time



