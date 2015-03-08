_ = require 'lodash'


util = {

	# redirect generator
	redirect: (path) ->
		(req, res) ->
			res.redirect(path)

	# Generates a route handler
	simpleView: (data_cb, template_cb) ->
		(req, res, next) ->
			data = if data_cb then data_cb(req, res) else {}
			#console.log( 'tpl render', name, data )
			res.write( template_cb( data ) )
			res.end()

	# Generates a route handler using the Express view renderer
	simpleExpressView: (name, getContext) ->
		(req, res, next) ->
			data = if getContext then getContext(req, res) else {}
			if not data
				console.warn('No data for '+name)
			#console.log( 'render', name, data )
			res.render( name, data )
}

# Controller baseclass
Function::property = (prop, desc) ->
	Object.defineProperty @prototype, prop, desc

class Controller
	###
	The server-side controller is a helper class to provides handlers
	for the Express app routes. These routines mainly concern getting the 
	server-side template data and making the call to res.render.

	The important controller of the UI is client-side, so this can deal 
	with less dynamic things. Configuratin is currently done in config/routes.

	TODO: look into metadata based MVC. Would need some schema framework 
			for models elsewhere, and deal with Controller-View here.
	###
	constructor: (opts)->
		{@name, @title, @core} = opts
	#@property 'title',
	#	get: -> @core.meta.title
	@init: ( core, type=Controller, opts )->
		new type _.defaults opts, core: core

class StaticController extends Controller

	constructor: (opts)->
		@options = _.extend(@options, opts)
		super opts


module.exports = ( core )->

	_.merge core.base, util,
		type:
			base: Controller
			static: StaticController
	
	{}


