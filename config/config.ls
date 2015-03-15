#path = require('path')
#rootPath = path.normalize(__dirname + '/..')

module.exports =

	production:
		#root: rootPath
		root: __dirname
		modules: [
			'node/dotmpe/x-bookmarks'
		]

	test:
		#root: rootPath
		root: __dirname
		app: name: 'Nodejs Express Socket IO Demo (test)'

	development:
		root: __dirname
		app: name: 'Nodejs Express Socket IO Demo (dev)'
		lib:
			js:
				socket_io: '/socket.io/socket.io.js'
				jquery: '/components/jquery/dist/jquery.js'
				bootstrap: '/components/bootstrap/dist/js/bootstrap.js'
				coffeescript: '/components/coffee-script/extras/coffee-script.js'
			coffeescript:
				app: '/script/app.coffee'
			css: 
				'/components/bootstrap/dist/css/bootstrap.css'
				'/components/bootstrap/dist/css/bootstrap-theme.css'
				'/style/app.css'
		modules:
			'dotmpe/x-bookmarks'
			'dotmpe/project'
			'dotmpe/browser'
			'dotmpe/x/backbone'
			#'dotmpe/x/backbone/backend',
			#'dotmpe/x/backbone/frontend'
			
		database:
			main:
				# knex 0.6.20 config
				client: 'sqlite3'
				connection:
					filename: __approot + '/main.sqlite3.db'
					#filename: '/Users/berend/htdocs/.cllct/bms.sqlite'
				migrations:
					tableName: 'knex_migrations'
					directory: __approot + '/migrations/main'

