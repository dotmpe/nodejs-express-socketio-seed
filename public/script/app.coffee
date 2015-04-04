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
		window.location.hash = ''

	socket.on 'connect', -> 
		session_start = Date.now()
		if reload_after
			console.log 'Reconnected to server', (session_start - reload_after) / 1000, 'sec later'
		else
			console.log 'Connected to server'

		# anticipate server reset for file-reload; reload client too
		if reset
			window.location.hash = heartbeat
			window.location.reload()

		# TODO announce, handshake; (re)set/update any session based client components
		# should validate client (meta)data
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

	# XXX some client side socket io examples
	socket.on 'message', (msg)->
		console.log 'message from server: '+msg

	socket.on 'test', (data)->
		console.log [ 'socket.io test', data ]

$(document).ready () ->
	console.log 'CoffeeScript, jQuery ready'

	init()



