
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

# create express and socket server
express = require("express")
app = module.exports = express()
server = require("http").createServer(app)
io = require("socket.io").listen(server)
app.set 'socketio', io

#require('./config/data') app, config

# Express settings
require("./config/express") app, config

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
