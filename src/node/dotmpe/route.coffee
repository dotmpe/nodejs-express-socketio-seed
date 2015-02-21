applyRoutes = (app, root, controller)->
	if !app
		console.log root, controller
		throw "Missing app"
	for name, route of controller.route
		url = [ root, name ].join('/')
		if route.route
			applyRoutes app, url, route
		for method in ['all', 'get', 'put', 'post', 'options', 'delete']
			cb = route[method]
			if cb
				console.log 'route', method, url
				app[method] url, cb

module.exports = {
	applyRoutes: applyRoutes
}
