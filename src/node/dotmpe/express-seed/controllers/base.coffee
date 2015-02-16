_ = require 'underscore'


util = {

	# redirect generator
	redirect: (path) ->
		(req, res) ->
			res.redirect(path)

	# simpleRes generates a route handler from a template path and callback for context
	simpleRes: (name, getContext) ->
		(req, res, next) ->
			data = if getContext then getContext() else {}
			if not data
				console.warn('No data for '+name)
			console.log( 'render', name, data )
			res.render( name, data )
}

# Controller baseclass
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
		{@name} = opts

class StaticController extends Controller
	constructor: (opts)->
		@options = _.extend(@options, opts)
		super opts


# static export for other controllers
module.exports = (core, base)->
	_.extend( base, 
		util, 
		type:
			base: Controller
			static: StaticController
	)


