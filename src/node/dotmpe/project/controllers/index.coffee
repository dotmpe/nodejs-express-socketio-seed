_ = require 'underscore'
jade = require 'jade'

projectTemplate = jade.compileFile require.resolve '../views/index.jade'

module.exports = ( module )->

	projectData = ()->
		page: title: "Projects", summary: module.core.config.app.name
	base = module.core.base

	_.extend( base,
		route: project: get: base.simpleView 'index', projectData, projectTemplate
	)


