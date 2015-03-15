###

.mpe 2015 Some code to quickly start an extensible Express app.

	'express-mvc/0.1'

	'express-mvc-ext/0.1'

###
path = require 'path'
_ = require 'underscore'

metadata = require './metadata'
applyRoutes = require('./route').applyRoutes


class Component

	constructor: ( opts ) ->
		{@app, @server, @root, @pkg, @config, @meta, @url, @path} = opts
		@base = {}
		@controllers = {}
		@routes = {}

	@load_config: ( name )->
		{}

	configure: () ->
		p = @root || @path

		@controllerPath = path.join p, 'controllers'
		@modelPath = path.join p, 'models'
		@viewPath = path.join p, 'views'

		@load_controllers()

	load_controllers: ()->
		if ! @meta.controllers
			console.warn 'No controllers for component', @name
			return

		p = @root || @path
		
		# load configured controllers
		for ctrl in @meta.controllers

			ctrl_path = path.join( p, ctrl )
			@controllers[ ctrl ] = require ctrl_path
			ctrlr = @controllers[ ctrl ] @, @base

			# FIXME: apply routes only once. Currently controllers each merge base.{type,route}
			newRoutes = applyRoutes( @app, @url, ctrlr )
			_.extend @routes, newRoutes

			console.log 'Component: loaded', ctrl, 'controller'

		if @meta.default_route
			defroute = path.join( @url, @meta.default_route )
			@app.all @url, @base.redirect(defroute)


class Core extends Component

	constructor: (opts) ->
		@name = "Express Seed Core"
		super opts

	# static init for core, relay app init to core module, then init
	@config: ( core_path )->
		core_file = path.join core_path, 'main'
		core_seed_cb = require core_file
		# Return core opts
		opts = core_seed_cb __approot
		opts


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
		@modules = {}

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

		super

	###
		CoreV01.load_modules
	###
	load_modules: ()->
		#console.log 'load_modules', @config.modules
		modroot = path.join __approot, @config.src || 'src'
		mods = _.extend( [], @config.modules, @meta.modules )
		for modpath in mods
			fullpath = path.join( modroot, modpath )
			mod = ModuleV01.load( @, fullpath )
			mod.configure()
			@modules[ mod.meta.name ] = mod
			console.log 'loaded module', modpath, mod.meta.name

	###
		CoreV01.get_all_components
	###
	get_all_components: ()->
		comps = [ @ ]
		_.union comps, _.values( @modules )

	start: ()->
		self = @
		@server.listen @app.get("port"), ->
			console.log "Express server listening on port " + self.app.get("port")

	@load: ( core_path )->
		# TODO sync with Module.load:
		#md = metadata.load( core_path )
		#if not md
		#	md = type: 'express-mvc/0.1'
		# static configuration
		opts = Core.config( path.join( __approot, core_path ) )
		new CoreV01( opts )


class ModuleV01 extends Component

	###
	
	| Handle Express MVC extension modules.

	- handlers
	- routes

	###

	# Get new instance holding module metadata and config.
	constructor: ( opts )->
		{@core} = opts
		if !opts.name
			opts.name = 'ModuleV01'
		super opts

	# Static methods
	
	# Read module metadata from path, load MVC-ext-type modules
	@load: ( core, from_path )->
		md = metadata.load( from_path )
		if !md
			console.warn "No module to load from", from_path
			return
		for mdc in md
			if mdc.type == 'express-mvc-ext/0.1'
				meta = metadata.resolve_mvc_meta from_path, mdc
				ModuleClass = module_classes[ meta.ext_version ]
				opts = ModuleClass.config( core, meta, from_path )
				if !meta.controllers
					console.error "Missing MVC meta for ", mdc
				return new ModuleClass( opts )

	@config: ( core, meta, from_path )->
			#ModuleClass = module_classes[ meta.ext_version ]
			# TODO module_config = ModuleClass.load_config( from_path )
			meta: meta
			core: core
			app: core.app
			base: core.base
			path: from_path


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
	#load_module: load_module,
}

