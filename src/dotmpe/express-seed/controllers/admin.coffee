_ = require 'lodash'


module.exports = (core, base) ->

	base = core.base

	modules = new base.type.Base core, 'admin/modules', {}

	_.merge( base, 

		# Dynamic define of resource subtypes?
		#types = app.get 'controllers'
		#class Admin extends types.Page
		#app.get 'controllers' ['page']
		#
		# static route pre-config
		
		route:

			admin: 
				get: (req, res) ->
					res.render 'admin', page: title: "Admin"
				route:
					template: get: base.simpleExpressView 'admin/template', () ->
						page: title: "Template"
						menu: core.meta.menu

			modules:
				get: base.simpleExpressView 'admin/modules', ()->
					page: title: "Modules"
					components: core.get_all_components()
					menu: core.meta.menu
				route:
					list: 
						get: base.simpleExpressView 'admin/modules', () ->
							page: title: "Modules"
							routes: core.routes
							modules: core.app.get('modules')
	)

