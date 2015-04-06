###

###

_ = require 'lodash'
fs = require 'fs'
path = require 'path'
jade = require 'jade'


docTemplate = jade.compileFile require.resolve '../views/docs.jade'
projectTemplate = jade.compileFile require.resolve '../views/index.jade'

listProjects = ->
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

currentProject = ->
  pkg_fn = path.join process.cwd(), 'package.json'
  if (fs.existsSync(pkg_fn))
    require pkg_fn

listDocuments = ->
  docnames = []
  names = fs.readdirSync process.cwd()
  for name in names
    if name.substr(-4) == '.rst'
      docnames.push name[0..-5]
  docnames

module.exports = ( module ) ->

  io = module.core.app.get('io')
  io.sockets.on 'connection', ( socket ) ->
    require('./socket')(socket)

  base = module.core.base

  projectDir = process.cwd()

  # Controller for project index template
  projectIndex = new base.type.Base module, 'index',
    current: pkg: currentProject()
    projects: listProjects()
    documents: listDocuments()
    page: title: "Projects", summary: module.core.config.app.name

  # Rst endpoint view
  class DocViewer extends base.type.Base
    getContext: ( req, res ) ->
      ctx = super
      ctx.docpath = req.query.docpath
      # script/project is build by r.js from dotmpe/project/client
      #ctx.head.js.require_main.push "/script/project/main.js"
      ctx

  # controller for docs tpl
  docview = new DocViewer module, 'docs',
    title: "Doc viewer"

  # Angular project client
  class NgViewer extends base.type.Base
    getContext: ( req, res ) ->
      ctx = super
      ctx.docpath = req.query.docpath
      # script/project is build by r.js from dotmpe/project/client
      #ctx.head.js.require_main.push "/script/project/main.js"
      ctx

  # TODO: or look at express-socket for GUI excersize
  ngview = new NgViewer module, 'ng-client',
    title: "Doc viewer"

  # Render partials for angular
  project_ng_view = (req, res, next) ->
    view = req.params.view
    action = req.params.action || view
    tplPath = path.join( module.viewPath, 'ng', view, action )
    template = jade.compileFile "#{tplPath}.jade"
    res.write template url: base: '/project/ng-client/'
    res.end()

  route:
    'doap.rdf':
      get: 'Base(doap)'
    project:
      route:
        document:
          get: (req, res, next) ->
            if not req.query.docpath
              req.query.docpath = 'ReadMe'
            docview.get( req, res, next )

        'ng-client': all: _.bind ngview.get, ngview

        ng: route:
          '': base.redirect '/project/ng-client'
          client: base.redirect '/project/ng-client'
          view: route: $view: route: $action: all: project_ng_view

      #get: _.bind projectIndex.get, projectIndex

      get: ( req, res, next) ->
        data = _.merge projectIndex.getContext(req, res), projectIndex.seed
        res.write projectIndex.template data
        res.end()

  meta:
    menu:
      project:
        _menu: 'Project'
        ng: _url: '/project/ng-client', _label: 'NG Client'
        current: _url: '/project', _label: 'Current'
        docview: _url: '/project/document', _label: 'DocView'
        doap:
          _url: '/doap.rdf'
          _label: 'DOAP'


