_ = require 'lodash'


module.exports = ( module ) ->

  base = module.core.base

  # Define server-side controller for route handlers, template context
  class Browser extends base.type.Base
    getContext: ->
      ctx = super
      #ctx.head.js.r_main = "/script/browser/common.js"
      #ctx.head.coffeescript.main = '/script/browser/main.coffee'
      #ctx.head.js.require_main.push "/script/browser/main.js"
      ctx

  # Init controller with
  browser = new Browser module, 'main', {}

  # return module object with routes/handlers and metadata
  route: browser: get: _.bind browser.get, browser
  meta: menu: browser: _url: '/browser', _label: 'Browser'


