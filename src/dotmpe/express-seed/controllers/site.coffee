_ = require 'lodash'


module.exports = ( core ) ->

  base = core.base

  # extend Page and Site of base controller
  class StaticPage extends base.type.Controller

    getPage: (name) ->
      (req, res) ->
        res.render name, data
      base.simpleExpressView 'site', (context) ->
        _.extend {}, context,
          page: title: "Home", summary: core.config.app.name

  #tplpath = require.resolve '../views/site/index.jade'
  site = new base.type.Base core, 'site/index',
    page: title: "Home", summary: core.config.app.name

  #tplpath = require.resolve '../views/site/about.jade'
  about = new base.type.Base core, 'site/about',
    page: title: "About", summary: core.config.app.name

  #class Site extends Page
  #  constructor: (opts) ->
  #    super opts

  # export new types, and route/page configuration
  _.merge core.base,
    type:
      page: StaticPage

  route:
    home: get: _.bind site.get, site
    about: get: _.bind about.get, about

