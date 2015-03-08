###

###

_ = require 'lodash'
fs = require 'fs'
path = require 'path'
jade = require 'jade'


docTemplate = jade.compileFile require.resolve '../views/docs.jade'
projectTemplate = jade.compileFile require.resolve '../views/index.jade'

listProjects = ()->
	dataDir = process.cwd()
	projectsDir = path.join dataDir, 'project'

	if (!fs.existsSync(projectsDir))
		return ['No project dir']

	names = fs.readdirSync projectsDir

	results = []
	for name in names
		projectPath = path.join(dataDir, 'project', name)
		if (!fs.existsSync(projectPath))
			continue
		if (fs.statSync(projectPath).isDirectory())
			results.push name
	results

currentProject = ()->
	pkg_fn = path.join process.cwd(), 'package.json'
	if (fs.existsSync(pkg_fn))
		require pkg_fn

module.exports = ( module )->

	base = module.core.base

	projectDir = process.cwd()

	projectData = ()->
		current: pkg: currentProject()
		projects: listProjects()
		page: title: "Projects", summary: module.core.config.app.name

	docData = (req, res)->
		if not req.query.docpath
			req.query.docpath = 'ReadMe'

		ctrlr = base.type.base.init module.core, base.type.page,
			title: "Doc viewer"

		pkg: module.core.pkg
		head: module.core.config.lib
		#head: _.merge module.core.config.lib, js: 'proj-doc': '/script/project.js'
		core: module.core
		isActive: ()-> false
		page: ctrlr
		modules: []
		docpath: req.query.docpath

	_.merge base,

		route: 
			project: 
				route:
					document:
						get: base.simpleView docData, docTemplate
				get: base.simpleView projectData, projectTemplate


