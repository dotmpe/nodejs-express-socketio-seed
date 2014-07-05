base = require(__base+'controllers/base')

module.exports = (app, config) ->
	# Dynamic define of resource subtypes?
	#types = app.get 'controllers'
	#class Admin extends types.Page
	#app.get 'controllers' ['page']
	#
	# static route pre-config
	route:
		admin:
			get: (req, res) ->
				res.render 'admin'
		modules:
			get: base.simpleRes 'admin/modules', ()->
				page: title: "Modules"
			route:
				list: 
					get: base.simpleRes 'admin/modules', () ->
						page: title: "Modules"
						modules: app.get('modules')

