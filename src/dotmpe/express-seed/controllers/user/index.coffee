###

- Should load after User model is configured

###

_ = require 'lodash'
flash = require('connect-flash')
session = require('cookie-session')
bodyParser = require('body-parser')
cookieParser = require('cookie-parser')
methodOverride = require('method-override')

core = require( "#{__noderoot}/src/dotmpe/nodelib/module" )
	.load_core( 'src/dotmpe/express-seed' )
base = core.base
utils = require "#{__noderoot}/src/dotmpe/nodelib/util"


handlers = {}

handlers.session = (req, res) ->
	redirectTo = if req.session.returnTo then req.session.returnTo else '/'
	delete req.session.returnTo
	res.redirect redirectTo
	return

handlers.signin = (req, res) ->

###*
# Show login form
###

handlers.login = (req, res, next) ->
	template_cb = base.compileTemplate 'users/login', core
	data = _.merge {},
		core.base.basicContext( core ),
		config: core.config
		title: 'Login'
		page: title: 'Login page'
		message: req.flash('error')
	res.write( template_cb( data ) )
	res.end()


###*
# Show sign up form
###

handlers.signup = (req, res) ->
	template_cb = base.compileTemplate 'users/signup', core
	User = core.load_model 'user'
	data = _.merge {}, base.basicContext( core ),
		title: 'Sign up'
		user: new User
	res.write( template_cb( data ) )
	res.end()


###*
# Logout
###

handlers.logout = (req, res) ->
	req.logout()
	res.redirect core.config.urls.login


###*
# Create user
###

handlers.create = (req, res) ->
	User = core.load_model 'user'
	user = new User(req.body)
	user.provider = 'local'
	user.save().then((user) ->
		# manually login the user once successfully signed up
		req.logIn user, (err) ->
			if err
				return next(err)
			res.redirect '/'
		return
	).catch (err) ->
		data = _.merge {}, base.basicContext( core ),
			error: utils.errors(err.errors)
			user: user
			title: 'Sign up'
		res.render 'users/signup', data
		return
	return

###*
#  Show profile
###

handlers.show = (req, res) ->
	user = req.profile
	data = _.merge {}, base.basicContext( core ),
		title: user.name
		user: user
	res.render 'users/show', data
	return

###*
# Find user by id
###

handlers.user = (req, res, next, id) ->

	user = core.load_model 'user'
	#Bookshelf = require('bookshelf')
	#User = Bookshelf.session.model('User')
	#Users = Bookshelf.session.collection('Users')

	user.Users
	.query(where: id: id)
	.fetchOne()
	.then((user) ->
		if !user
			return next(new Error('Failed to load User ' + id))
		req.profile = user
		next()
		return
	).catch (err) ->
		next err
		return
	return


# Export for Express-Demo
module.exports = ( core )->
	
	be = require('./backend_passport')( null, core.config )

	core.load_model 'user'

	config = require('./config_default')( be.passport, core.config )

	app = core.app

	# cookieParser should be above session
	app.use(cookieParser())

	app.use bodyParser()
	app.use methodOverride()

	app.use(session(
		secret: 98172347812481231296319237812937#appConfig.site.salt
		keys: ['key1']
		cookie: 
			maxAge: 1000*60*60 
	))

	# use passport session
	app.use(be.passport.initialize())
	app.use(be.passport.session())

	# connect flash for flash messages - should be declared after sessions
	app.use(flash())

	params:
		userId: handlers.user

	route:
		login: get: handlers.login
		signup: get: handlers.signup
		logout: get: handlers.logout
		users:
			post: handlers.create
			route:
				$userId:
					get: handlers.show
				session: {
					post: [ be.local.auth, handlers.session ]
				}
		auth:
			route:
				facebook:
					get: [ be.facebook.auth, handlers.signin ]
					route: callback: get: [ be.facebook.cb, handlers.session ]
				github:
					get: [ be.github.auth, handlers.signin ]
					route: callback: get: [ be.github.auth, handlers.session ]
				twitter:
					get: [ be.twitter.auth, handlers.signin ]
					route: callback: get: [ be.twitter.auth, handlers.session ]
				google:
					get: [ be.google.auth, handlers.signin ]
					route: callback: get: [ be.google.cb, handlers.session ]
				linkedin:
					get: [ be.linkedin.auth, handlers.signin ]
					route: callback: get: [ be.linkedin.cb, handlers.session ]


