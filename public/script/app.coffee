socket = null
reset = null
heartbeat = null
session_start = null
reload_after = null

init = ->

	console.log 'Initializing Socket.IO client'
	socket = io.connect()

	if window.location.hash
		reload_after = parseInt window.location.hash.substr(1)
		window.location.hash = null

	socket.on 'connect', -> 
		session_start = Date.now()
		if reload_after
			console.log 'Reconnected to server', (session_start - reload_after) / 1000, 'sec later'
		else
			console.log 'Connected to server'
		if reset
			# anticipate server reset for file-reload; reload client too
			window.location.hash = heartbeat
			window.location.reload()
		socket.send('hi')

	socket.on 'disconnect', -> 
		console.warn 'Disconnected from server @', (heartbeat - session_start) / 1000, 'sec'
		reset = true

	# server sends ping each 5 seconds
	socket.on 'ping', ( timestamp )->
		console.log 'server @', timestamp, 'ms, latency', Date.now() - timestamp, 'ms'
		if reload_after
			console.log 'server downtime', (timestamp - reload_after) / 1000, 'sec'
			reload_after = null
		heartbeat = timestamp

	socket.on 'message', (msg)->
		console.log 'message from server: '+msg

	socket.on 'test', (data)->
		console.log [ 'socket.io test', data ]


$(document).ready () ->
	console.log 'CoffeeScript, jQuery ready'

	init()



