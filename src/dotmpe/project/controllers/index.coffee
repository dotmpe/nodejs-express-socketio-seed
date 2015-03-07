_ = require 'underscore'
fs = require 'fs'
path = require 'path'
jade = require 'jade'


projectTemplate = jade.compileFile require.resolve '../views/index.jade'

listProjects = ()->
	dataDir = process.cwd()
	names = fs.readdirSync path.join dataDir, 'project'
	results = []
	for name in names
		projectPath = path.join(dataDir, 'project', name)
		if (!fs.existsSync(projectPath))
			continue
		if (fs.statSync(projectPath).isDirectory())
			results.push name
	results


module.exports = ( module )->

	projectData = ()->
		projects: listProjects()
		page: title: "Projects", summary: module.core.config.app.name

	base = module.core.base

	_.extend( base,
		route: project: get: base.simpleView 'index', projectData, projectTemplate
	)


