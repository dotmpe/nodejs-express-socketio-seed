# jrc:import angularAMD socket.io angular.socket-io
( angularAMD ) ->

  console.log ('dotmpe-project-ng.services')

  angular.
    module('dotmpe-project-ng.services', [])
    .factory('socket', (socketFactory) ->
      console.log 'socketFactory', socketFactory
      return socketFactory()
    )
    .value('version', '0.1')

