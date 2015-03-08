###
Do the heavy lifting for Express. 

This module exports an options object to pass along to
dotmpe.nodelib.module.Component

###

path = require 'path'
express = require 'express'

rootPath = path.normalize(__dirname)


init_express = ( app, server, config, pkg, envname )->

	app.set('showStackError', true)

	# Logging
	log
	if envname != 'dev'
		winston = require('winston')
		log = 
			stream: 
				write: (message, encoding) ->
					winston.info(message)
	else 
		log = 'dev'

	# Don't log during tests
	envname != 'test' ? app.use(logger(log))

	# Templating
	app.set 'views', path.join rootPath, 'views'
	app.set 'view engine', 'jade'

	# expose package.json, config.lib to Express views
	app.use (req, res, next)->
		res.locals.pkg = pkg
		res.locals.head = config.lib
		next()
	
	helpers = require('view-helpers')
	app.use(helpers(pkg.name))

	envname == 'development' ?
		app.use express.errorHandler()
		app.locals.pretty = true

	app.use((err, req, res, next)->
		if err.message && (~err.message.indexOf('not found') || (~err.message.indexOf('Cast to ObjectId failed')))
			return next()
		console.error(err.stack)
		res.status(500).render('500', { error: err.stack })
	)

#load_controllers = ( app, config )->

module.exports = ( approot )->

	app = module.exports = express()

	#envname = process.env.NODE_ENV or 'development'
	envname = app.get 'env'

	app.set 'port', process.env.PORT || 3000

	server = require("http").createServer(app)

	configs = require path.join approot, 'config/config'
	config = configs[envname]

	pkg_file = path.join approot, 'package.json'
	pkg = require( pkg_file )

	init_express( app, server, config, pkg, envname )

	app.use express.static path.join approot, 'public'

	io = require("socket.io").listen(server)


	# Apply routes for socket TODO move to controller
	io.sockets.on 'connection', (socket) ->
		socket.on 'disconnect', ()->
			console.log 'client disconnected'
		socket.on 'message', (msg)->
			console.log 'message from client: '+msg
			socket.send('hello!')
		socket.emit 'test',
			foo: 'Bar'


	app: app
	server: server

	pkg: pkg
	root: rootPath
	config: config

	meta:
		controllers: [ 'controllers/base', 'controllers/site', 'controllers/admin' ]
		default_route: 'home'

		menu:
			home: url: '/home', label: 'Home'
			about: url: '/about', label: 'About'
			module: url: '/modules', label: 'Modules'

		page:
			title: "Untitled"

