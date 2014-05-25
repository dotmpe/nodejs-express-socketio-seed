
redirect = (path) ->
	(req, res) ->
		res.redirect(path)

simpleRes = (name, getData) ->
	(req, res, next) ->
		data = if getData then getData() else {}
		res.render(name, data)

module.exports = ( app, io, config ) ->

	app.route('/home').all(simpleRes('home', () ->
		page: title: "Home", summary: config.app.name
	))
	app.route('/').all(redirect('/home'))

	app.route('/modules/index')
		.all(simpleRes('modules', () ->
			page: title: "Modules"
			modules: app.get('modules')
		))

	io.sockets.on 'connection', (socket) ->
		socket.emit 'test',
			foo: 'Bar'
		
