simpleRes = require(__base+'controllers').simpleRes
module.exports = (app, config) ->
	home: get: simpleRes 'site/home', ()->
		page: title: "Home", summary: config.app.name
	about: get: simpleRes 'site', ()->
		page: title: "About", summary: config.app.name

