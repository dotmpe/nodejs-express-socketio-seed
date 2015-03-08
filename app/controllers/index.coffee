_ = require 'underscore'
base = require './base'


# Controller baseclass
class Controller
	###
	The server-side controller is a helper class to provides handlers
	for the Express app routes. These routines mainly concern getting the 
	server-side template data and making the call to res.render.

	The important controller of the UI is client-side, so this can deal with less dynamic things.
	###
	constructor: (opts)->
		{@name} = opts


module.exports = (app, config) ->
	#InvidiaMVCBase
		
