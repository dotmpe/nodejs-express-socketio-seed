path = require 'path'
fs = require 'fs'
_ = require 'underscore'


class Module
	# Object to hold paths and loaded controllers
	constructor: (@name, @config) ->
	configure: (extroot) ->
		@moduleRoot = path.join extroot, @name
		@viewPath = path.join @moduleRoot, 'views'
		@modelPath = path.join @moduleRoot, 'models'
		@controllerPath = path.join @moduleRoot, 'controllers'
	apply: (app, io) ->
		@handlers = _.extend(
			# load module controller
			require( @controllerPath )(app, io, @)
			# extend with convenience function
			redirect: (path) ->
				(req, res) ->
					res.redirect(path)
		)
		# initialize route config for this module
		@routes = require('./routes.'+@name)(app, io, @)

classes = [0, Module]

getModClass = (name, config)->
	v = config.version || 1
	classes[v]

module.exports = (app, io, config) ->

	modules = []
	extroot = path.join config.root, 'app', 'ext'
	fs.readdir extroot, (files, dirs) ->
		for name in dirs
			ModClass = getModClass( name, config )
			module = new ModClass( name, config )
			module.configure extroot
			module.apply app, io 
			modules.push module
	return modules



