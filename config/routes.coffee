applyRoutes = (app, root, controller)->
	for name, route of controller.route
		url = [ root, name ].join('/')
		if route.route
			console.log(['applySub', url, route.route])
			applyRoutes app, url, route
		for method in ['all', 'get', 'put', 'post', 'options', 'delete']
			cb = route[method]
			if cb
				app[method] url, cb

module.exports = ( app, config ) ->

	index = require(__base+'controllers/base')

	# Apply routes for page controllers
	base = require(__base+'controllers/base')
	site = require(__base+'controllers/site') app, config
	admin = require(__base+'controllers/admin') app, config

	applyRoutes(app, '', base)
	applyRoutes(app, '', site)
	applyRoutes(app, '', admin)
	app.all '/', index.redirect('/home')

	# Apply routes for socket TODO move to controller
	io = app.get 'socketio'
	io.sockets.on 'connection', (socket) ->
		socket.on 'disconnect', ()->
			console.log 'client disconnected'
		socket.on 'message', (msg)->
			console.log 'message from client: '+msg
			socket.send('hello!')
		socket.emit 'test',
			foo: 'Bar'

	# return seed-data for core module
	name: 'builtin'
	config: config
	menu:
		home: url: '/home', label: 'Home'
		about: url: '/about', label: 'About'
	page:
		title: "Untitled"

