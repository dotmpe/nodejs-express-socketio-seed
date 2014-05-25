
/*!
 * See LICENSE.txt for full copyright notice.
 *
 * Copyright (C) 2014 Berend van Berkum (.mpe) <dev@dotmpe.com>
 * GNU GPL v3
 */

/* Enable coffeescript */
require('coffee-script/register');
/* Enable LiveScript */
require('LiveScript')

var express = require('express')

// Load configurations
var env = process.env.NODE_ENV || 'dev'
	, config = require('./config/config')[env]

// create express and socket server
var app = module.exports = express()
var server = require('http').createServer(app)
var io = require('socket.io').listen(server)

//require('./config/data')(app, config)

require('./config/express')(app, config)

// Express settings
require('./config/routes')(app, io, config)

// Bootstrap routes
require('./config/modules')(app, io, config)

// Module try-out
exports = module.exports = app

// Start ...
server.listen(app.get('port'), function () {
	console.log('Express server listening on port ' + app.get('port'));
});

// expose app
exports = module.exports = app

