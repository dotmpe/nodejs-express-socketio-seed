_ = require 'lodash'


module.exports = (core, base) ->

  base = core.base

  modules = new base.type.Base core, 'admin/modules', {}

  # Dynamic define of resource subtypes?
  #types = app.get 'controllers'
  #class Admin extends types.Page
  #app.get 'controllers' ['page']
  #
  # static route pre-config
  
  route:

    admin: 
      get: (req, res) ->
        res.render 'admin',
          _.merge {}, core.base.basicContext(core),
            page: title: "Admin"
            user: req.user
      route:
        template: get: base.simpleExpressView 'admin/template', () ->
          _.merge {}, core.base.basicContext(core),
            page: title: "Template"

    modules:
      get: base.simpleExpressView 'admin/modules', ()->
        _.merge {}, core.base.basicContext(core),
          page: title: "Modules"
          components: core.get_all_components()
      route:
        list: 
          get: base.simpleExpressView 'admin/modules', () ->
            _.merge {}, core.base.basicContext(core),
              page: title: "Modules"
              modules: core.modules
              components: core.get_all_components()

  meta:
    menu:
      _g1:
        _menu: 'Admin'
        admin: _url: '/admin', _label: 'Admin'
        _d1: _divider: true
        template: _url: '/admin/template', _label: 'Template'
        _d2: _divider: true
        user1: _url: '/users/1', _label: 'User 1'


