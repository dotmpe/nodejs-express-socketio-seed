_ = require 'lodash'


module.exports = ( core )->

	base = core.base

	# extend Page and Site of base controller
	class StaticPage extends base.type.static

		getPage: (name) ->
			(req, res) ->
				res.render name, data
			base.simpleExpressView 'site', (context)->
				_.extend {}, context, 
					page: title: "Home", summary: core.config.app.name

	#class Site extends Page
	#	constructor: (opts)->
	#		super opts

	# export new types, and route/page configuration
	_.merge core.base,
		type:
			page: StaticPage
		route:
			home: get: base.simpleExpressView 'site', ()->
				page: # TODO new StaticPage()
					title: "Home", summary: core.config.app.name
				core: core
			about: get: base.simpleExpressView 'site/about', ()->
				page: title: "About", summary: core.config.app.name

