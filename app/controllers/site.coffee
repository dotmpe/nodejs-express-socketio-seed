_ = require 'underscore'

index = require(__base+'controllers')

class Page extends index.type.controller
	getPage: (name) ->
		(req, res) ->
			res.render name, data
		index.simpleRes 'site', (context)->
			_.extend context, 
				page: title: "Home", summary: config.app.name

class Site extends Page
	constructor: (opts)->
		super opts

module.exports = (app, config) ->
	#types = app.get 'types'

	#class Admin extends types.Page

	type:
		page: Page
		site: Site
	route:
		home: get: index.simpleRes 'site', ()->
			page: title: "Home", summary: config.app.name
		about: get: index.simpleRes 'site/about', ()->
			page: title: "About", summary: config.app.name

