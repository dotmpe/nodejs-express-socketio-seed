module.exports = 
	redirect: (path) ->
		(req, res) ->
			res.redirect(path)

	simpleRes: (name, getData) ->
		(req, res, next) ->
			data = if getData then getData() else {}
			res.render(name, data)

