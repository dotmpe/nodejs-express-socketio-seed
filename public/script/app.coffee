$(document).ready () ->
	console.log 'CoffeeScript, jQuery ready'

	socket = io.connect()

	socket.on 'connect', () -> 
		console.log 'Connected to server'
		socket.send('hi')
	socket.on 'disconnect', () -> console.error 'Disconnected from server'
	socket.on 'message', (msg)->
		console.log 'message from server: '+msg
	socket.on 'test', (data)->
		console.log [ 'socket.io test', data ]

