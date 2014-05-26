class Controller
	constructor: (opts)->
		{@name} = opts
module.exports = 
	redirect: (path) ->
		(req, res) ->
			res.redirect(path)
	simpleRes: (name, getContext) ->
		(req, res, next) ->
			data = if getContext then getContext() else {}
			res.render(name, data)
	type:
		controller: Controller

