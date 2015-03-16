_ = require 'lodash'
path = require 'path'
jade = require 'jade'


util = {

	# redirect generator
	redirect: (path) ->
		(req, res) ->
			res.redirect(path)

	basicContext: ( core )->
		# view:includes/head
		page: title: 'Title'
		core: core
		app: core.app
		pkg: core.pkg
		head: core.config.lib
		# view:includes/header
		menu: core.meta.menu
		modules: [
			name: 'Mod A'
		]
		isActive: ()->
		# view:includes/messages
		#info: [
		#	"Info!"
		#]
		#errors: [
		#	"Error!"
		#]
		#success: [
		#	"Success!"
		#]
		#warning: [
		#	"Warning!"
		#]

	compileTemplate: ( name, component )->
		tplPath = require.resolve path.join component.viewPath, "#{name}.jade"
		jade.compileFile tplPath

	# Generates a route handler
	simpleView: (data_cb, template_cb) ->
		(req, res, next) ->
			data = if data_cb then data_cb(req, res) else {}
			res.write( template_cb( data ) )
			res.end()

	# Generates a route handler using the Express view renderer
	simpleExpressView: (name, getContext) ->
		(req, res, next) ->
			data = if getContext then getContext(req, res) else {}
			if not data
				console.warn('No data for '+name)
			res.render( name, data )
}

Function::property = (prop, desc) ->
	Object.defineProperty @prototype, prop, desc

# Controller baseclass
class Controller

	constructor: (core)->
		@component = core
		if core.core
			@module = core
			@core = @module.core
		else
			@core = core

class Base extends Controller

	###
	Base is the HTML client.
	###
	
	constructor: (core, @view, @seed)->
		super core
		@viewPath = path.join @component.viewPath, @view
		@template = jade.compileFile @viewPath+'.jade'
	
	getContext: ()->
		if not @core
			throw "Error"
		@view_vars =
		x = _.extend {},
			util.basicContext @core,
			@view_vars,
			@seed
		return x

	# Static methods
	@init: ( core, type=Controller, opts )->
		new type _.defaults opts, core: core

	get: ( req, res, next )->
		context = _.bind @getContext, @
		browserHandler = util.simpleView context, @template
		browserHandler req, res, next


module.exports = ( core )->

	_.merge core.base, util,
		type:
			Controller: Controller
			Base: Base
	
	{}


