_ = require 'lodash'


module.exports = (core, base) ->

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
			modules:
				get: base.simpleExpressView 'admin/modules', ()->
					page: title: "Modules"
					components: core.get_all_components()
				route:
					list: 
						get: base.simpleExpressView 'admin/modules', () ->
							page: title: "Modules"
							routes: core.routes
							modules: core.app.get('modules')
	)

