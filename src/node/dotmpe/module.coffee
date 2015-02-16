###

.mpe 2015 Some code to quickly start an extensible Express app.

	'express-mvc/0.1'

	'express-mvc-ext/0.1'

###
path = require 'path'

metadata = require './metadata'
applyRoutes = require('./route').applyRoutes


class Core

	constructor: (opts) ->

	# static init for core, relay app init to core module, then init
	@config: ( core_path )->
		core_file = path.join core_path, 'main'
		core_seed_cb = require core_file
		# Return core opts
		core_seed_cb __approot


class CoreV01 extends Core

	###

	| Encapsulate Express MVC for extension.
	| XXX what to use for models?

	- views
	- models
	- controllers

	###

	constructor: (opts) ->
		super opts
		{@app, @server, @root, @config, @meta, @url} = opts
		@controllers = {}
		@routes = {}
		console.log 'core', @meta

	configure: () ->
		# url must point to netpath, WITHOUT any *path* part (ie. including root)
		# so any sub-component can deal with abs or rel paths
		@url = @url || ''
		#@viewPath = @app.get 'views'
		@modelPath = path.join @root, 'models'

		# Add some more locals for Jade templates
		self = @
		@app.use (req, res, next)->
			res.locals.core = self
			res.locals.modules = []
			next()

		# Apply routes (load controllers, apply all url handlers)
		@controllerPath = path.join @root, 'controllers'
		@load_controllers()

	load_controllers: ()->
		base = {}
		console.log 'url', @url
		# load configured controllers
		for ctrl in @meta.controllers
			ctrl_path = path.join( @controllerPath, ctrl )
			@controllers[ ctrl ] = require ctrl_path
			ctrlr = @controllers[ ctrl ] @, base
			applyRoutes( @app, @url, ctrlr )
			console.log('Core: loaded', ctrl, 'controller')

		defroute = [ @url, @meta.default_route ].join()
		@app.all @url, base.redirect(defroute)

	start: ()->
		# Start ...
		self = @
		@server.listen @app.get("port"), ->
			console.log "Express server listening on port " + self.app.get("port")

	@load: ( core_path )->
		# static configuration
		opts = Core.config( path.join( __approot, core_path ) )
		new CoreV01( opts )


class ModuleV01

	###
	
	| Handle Express MVC extension modules.

	- handlers
	- routes

	###

	# Get new instance holding module metadata and config.
	constructor: ( @metadata, @config )->

	# FIXME: init like old seed project did
	configure: (extroot) ->
		@moduleRoot = path.join extroot, @name
		super @moduleRoot

	# Static methods
	
	# Read module metadata from path, load MVC-ext-type modules
	@load: ( path )->
		md = metadata.load( path )
		for mdc in md
			if mdc.type == 'express-mvc-ext/0.1'
				ModuleClass = module_classes[ mdc.ext_version ]
				module_config = ModuleClass.load_config
				module = new ModuleClass( md, module_config )
				return module

module_classes = {
	'0.1': ModuleV01
}


init = ( app_path )->
	global.__approot = app_path

load_core = ( core_path )->
	# Return core instance for path
	CoreV01.load( core_path )

load_module = ( mod_path )->
	module.configure extroot
	module.load app


module.exports = {
	init: init,
	classes:
		Core: CoreV01
		Module: ModuleV01
	load_core: load_core,
	load_module: load_module,
}

