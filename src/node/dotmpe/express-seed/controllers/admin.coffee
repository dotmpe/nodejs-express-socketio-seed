_ = require 'underscore'


module.exports = (core, base) ->

	_.extend( base, 
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
				get: base.simpleRes 'admin/modules', ()->
					page: title: "Modules"
				route:
					list: 
						get: base.simpleRes 'admin/modules', () ->
							page: title: "Modules"
							modules: core.app.get('modules')
	)

