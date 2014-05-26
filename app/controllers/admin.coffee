index = require(__base+'controllers')

module.exports = (app, config) ->
	#types = app.get 'types'

	#class Admin extends types.Page

	#app.get 'controllers' ['page']
	route:
		admin:
			get: (req, res) ->
				res.render 'admin'
		modules:
			get: index.simpleRes 'admin/modules', ()->
			sub:
				list: 
					get: index.simpleRes 'admin/modules', () ->
						page: title: "Modules"
						modules: app.get('modules')

