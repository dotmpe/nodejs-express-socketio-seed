_ = require 'underscore'

base = require(__base+'controllers/base')


# extend Page and Site of base controller
class StaticPage extends base.type.static
	getPage: (name) ->
		(req, res) ->
			res.render name, data
		base.simpleRes 'site', (context)->
			_.extend {}, context, 
				page: title: "Home", summary: config.app.name

#class Site extends Page
#	constructor: (opts)->
#		super opts


module.exports = (app, config) ->
	# export new types, and route/page configuration
	type:
		page: StaticPage
		#site: Site
	route:
		home: get: base.simpleRes 'site', ()->
			page: title: "Home", summary: config.app.name
		about: get: base.simpleRes 'site/about', ()->
			page: title: "About", summary: config.app.name

