navbar = null
navbar_timer = false

initnavbar = ()->
	navbar = $('nav.navbar')
	navbar.on 'mouseover', resettimeout
	navbar.on 'mouseout', ()->
		resettimeout()
		primetimeout()
	hidenavbar()

primetimeout = ()-> navbar_timer = setTimeout hidenavbar, 500
resettimeout = ()-> clearTimeout navbar_timer

hidenavbar = ()->
	if (navbar.is(':visible'))
		navbar.hide(200)
	
shownavbar = ()->
	if (!navbar.is(':visible'))
		navbar.show()
	
	
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

	$(document).on 'mousemove', (event)->
		if (event.clientY < 10)
			shownavbar()
	initnavbar()

