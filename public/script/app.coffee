$(document).ready () ->
	console.log 'CoffeeScript, jQuery ready'

	socket = io.connect 'http://localhost'
	socket.on 'test', (data)->
		console.log data

