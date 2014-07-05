
#!
# * See LICENSE.txt for full copyright notice.
# *
# * Copyright (C) 2014 Berend van Berkum (.mpe) <dev@dotmpe.com>
# * GNU GPL v3
# 

# Enable coffeescript 
require "coffee-script/register"

# Enable LiveScript 
require "LiveScript"

# Load configurations
env = process.env.NODE_ENV or "dev"
config = require("./config/config")[env]
global.__base = __dirname + '/app/'

# Frontend built

require("modulr").build("x-nodejs-htdocs", {
		environment: 'dev' # always build dev-code and add sourceURL
		paths: ['./lib', './vendor']
		# cwd:root: ['./public/script']
		lazyEval: ['x-nodejs-htdocs']
		minify: true
		minifyIdentifiers: true,
		resolveIdentifiers: true
	}, (err, result) ->
		if err
			console.error err
			throw err
		else
			require('fs')
				.writeFileSync('public/script/app-modulr-main.js', result.output, 'utf8')
)

# create express and socket server
express = require("express")
app = module.exports = express()
server = require("http").createServer(app)
io = require("socket.io").listen(server)
app.set 'socketio', io

#require('./config/data') app, config

# Express settings
require("./config/express") app, config

# Bootstrap server-side routes
#controllers = require(__base+'controllers')(app, config)

# Bootstrap routes, and get properties for built-in module
core = require("./config/routes") app, config

# Load modules and add instance list to app
require("./config/modules") app, core 

# Module try-out
exports = module.exports = app

# Start ...
server.listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")
  return


# expose app
exports = module.exports = app
