#path = require('path')
#rootPath = path.normalize(__dirname + '/..')

module.exports =

	production:
		#root: rootPath
		root: __dirname
		modules: [
			'dotmpe/x-bookmarks'
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
		modules: [
		]
