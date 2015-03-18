'use strict'

### Services ###


# Demonstrate how to register services
# In this case it is a simple value service.
define [
	'angular'
	'socket.io'
	'angular.socket-io'
], (angular)->

	console.log ('dotmpe-project-ng.services')

	angular.
		module('dotmpe-project-ng.services', []).
		factory('socket', (socketFactory)->
			console.log 'socketFactory', socketFactory
			return socketFactory()
		).
		value('version', '0.1')

