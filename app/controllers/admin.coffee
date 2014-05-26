simpleRes = require(__base+'controllers').simpleRes
module.exports = (app, config) ->
	admin:
		get: (req, res) ->
			res.render 'admin'
	modules:
		get: simpleRes 'admin/modules', ()->
		sub:
			list: 
				get: simpleRes 'admin/modules', () ->
					page: title: "Modules"
					modules: app.get('modules')


