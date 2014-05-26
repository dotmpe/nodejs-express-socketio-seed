path = require 'path'
express = require('express')
helpers = require('view-helpers')
winston = require('winston')

pkg = require('../package.json')

env = process.env.NODE_ENV || 'development'


module.exports = (app, config) ->

	app.set 'port', process.env.PORT || 3000
	app.set('showStackError', true)

	# Logging
	log
	if env != 'development'
		log = 
			stream: 
				write: (message, encoding) ->
					winston.info(message)
	else 
		log = 'dev'
	# Don't log during tests
	env != 'test' ? app.use(logger(log))

	# Templating
	app.set 'views', path.join __dirname, '..', 'app', 'views'
	app.set 'view engine', 'jade'

	# expose package.json, config.lib,# appcore and modules to views
	app.use (req, res, next)->
		res.locals.pkg = pkg
		res.locals.head = config.lib
		res.locals.core = app.get 'appcore'
		res.locals.modules = app.get 'appmodules'
		next()
	
	app.use(helpers(pkg.name))

	app.use express.static path.join __dirname, '..', 'public'

	app.get 'env' == 'development' ?
		app.use express.errorHandler()
		app.locals.pretty = true

	app.use((err, req, res, next)->
		if err.message && (~err.message.indexOf('not found') || (~err.message.indexOf('Cast to ObjectId failed')))
			return next()
		console.error(err.stack)
		res.status(500).render('500', { error: err.stack })
	)

	# Return app
	app

