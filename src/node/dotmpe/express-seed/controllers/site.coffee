_ = require 'underscore'


module.exports = (core, base)->

	# extend Page and Site of base controller
	class StaticPage extends base.type.static

		getPage: (name) ->
			(req, res) ->
				res.render name, data
			base.simpleExpressView 'site', (context)->
				_.extend {}, context, 
					page: title: "Home", summary: config.app.name

	#class Site extends Page
	#	constructor: (opts)->
	#		super opts

	_.extend( 

		base,

		# export new types, and route/page configuration
		type:
			page: StaticPage
			#site: Site
		route:
			home: get: base.simpleExpressView 'site', ()->
				page: title: "Home", summary: core.config.app.name
			about: get: base.simpleExpressView 'site/about', ()->
				page: title: "About", summary: core.config.app.name

	)

