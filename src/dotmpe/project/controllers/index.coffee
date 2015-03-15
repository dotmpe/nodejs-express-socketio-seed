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

	projectIndex = new base.type.Base module, 'index',
		current: pkg: currentProject()
		projects: listProjects()
		page: title: "Projects", summary: module.core.config.app.name
	
	class DocViewer extends base.type.Base
		getContext: ( req, res )->
			ctx = super
			ctx.docpath = req.query.docpath
			ctx.head.js.r_main = "/script/project/main.js"
			ctx

	ctrlr = new DocViewer module, 'docs',
		title: "Doc viewer"

	route: 
		project: 
			route:
				document:
					get: (req, res, next)->
						if not req.query.docpath
							req.query.docpath = 'ReadMe'
						ctrlr.get( req, res, next )
			get: _.bind projectIndex.get, projectIndex

	meta:
		menu:
			docview: url: '/project/document', label: 'DocView'


