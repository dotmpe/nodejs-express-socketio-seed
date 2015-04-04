path = require('path')
rootPath = path.normalize(__dirname + '/..')
templatePath = path.normalize(__dirname + '/../app/mailer/templates')
notifier = {
      service: 'postmark',
      APN: false,
      email: false,
      actions: ['comment'],
      tplPath: templatePath,
      key: 'POSTMARK_KEY',
      parseAppId: 'PARSE_APP_ID',
      parseApiKey: 'PARSE_MASTER_KEY'
}

module.exports =

	production:
		#root: rootPath
		root: __dirname
		lib:
			include_js: []
			js: {}
			css: {}
			coffeescript: {}
		modules: [
			'node/dotmpe/x-bookmarks'
		]

	test:
		root: __dirname
		app: name: 'Nodejs Express Socket IO Demo (test)'
		db: 'mongodb://localhost/noobjs_test'
		urls:
			base: '/'
		lib:
			include_js: []
			js: {}
			css: {}
			coffeescript: {}
		# old
		notifier: notifier
		facebook:
			clientID: 'APP_ID'
			clientSecret: 'APP_SECRET'
			callbackURL: 'http://localhost:3000/auth/facebook/callback'
		twitter:
			clientID: 'CONSUMER_KEY'
			clientSecret: 'CONSUMER_SECRET'
			callbackURL: 'http://localhost:3000/auth/twitter/callback'
		github:
			clientID: 'APP_ID'
			clientSecret: 'APP_SECRET'
			callbackURL: 'http://localhost:3000/auth/github/callback'
		google:
			clientID: 'APP_ID'
			clientSecret: 'APP_SECRET'
			callbackURL: 'http://localhost:3000/auth/google/callback'
		linkedin:
			clientID: 'CONSUMER_KEY'
			clientSecret: 'CONSUMER_SECRET'
			callbackURL: 'http://localhost:3000/auth/linkedin/callback'

	development:
		root: __dirname
		app: name: 'Nodejs Express Socket IO Demo (dev)'
		urls:
			base: '/'
			login: '/login'
		lib:
			js:
				socket_io: '/socket.io/socket.io.js'
				jquery: '/components/jquery/dist/jquery.js'
				bootstrap: '/components/bootstrap/dist/js/bootstrap.js'
				coffeescript: '/components/coffee-script/extras/coffee-script.js'
				angular: '/components/angular/angular.min.js'
				requirejs: '/components/requirejs/require.js'
				require_main: []
			# booststrap here without requirejs:
			include_js: [ 
				'socket_io'
				'jquery'
				'bootstrap'
				'coffeescript'
			]
			coffeescript:
				app: '/script/app.coffee'
			css:  [
				'/components/bootstrap/dist/css/bootstrap.css'
				'/components/bootstrap/dist/css/bootstrap-theme.css'
				'/style/app.css'
			]
		# extension modules to load:
		modules: [
			'dotmpe/x-bookmarks'
			'dotmpe/project'
			'dotmpe/browser'
			'dotmpe/x/backbone'
			'dotmpe/express-client'
			#'dotmpe/x/backbone/backend',
			#'dotmpe/x/backbone/frontend'
		]
		database:
			main:
				# knex 0.6.20 config
				client: 'sqlite3'
				connection:
					#filename: __approot + '/main.sqlite3.db'
					filename: '/Users/berend/htdocs/.cllct/bms.sqlite'
				migrations:
					tableName: 'knex_migrations'
					directory: __approot + '/migrations/main'

		# XXX old
		db: 'mongodb://localhost/noobjs_dev'
		notifier: notifier
		facebook:
			clientID: 'APP_ID'
			clientSecret: 'APP_SECRET'
			callbackURL: 'http://localhost:3000/auth/facebook/callback'
		twitter:
			clientID: 'CONSUMER_KEY'
			clientSecret: 'CONSUMER_SECRET'
			callbackURL: 'http://localhost:3000/auth/twitter/callback'
		github:
			clientID: 'APP_ID'
			clientSecret: 'APP_SECRET'
			callbackURL: 'http://localhost:3000/auth/github/callback'
		google:
			clientID: 'APP_ID'
			clientSecret: 'APP_SECRET'
			callbackURL: 'http://localhost:3000/auth/google/callback'
		linkedin:
			clientID: 'CONSUMER_KEY'
			clientSecret: 'CONSUMER_SECRET'
			callbackURL: 'http://localhost:3000/auth/linkedin/callback'



