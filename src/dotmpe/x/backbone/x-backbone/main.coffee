
_ = require 'lodash'
fs = require 'fs'
path = require 'path'
jade = require 'jade'


indexTpl = jade.compileFile require.resolve './index.jade'

module.exports = (module)->

	data = ()->
		_.merge {}, module.core.base.basicContext( module.core ),
		page: title: "Backbone", summary: "Testing Backbone"

	base = module.core.base

	route: 'dotmpe/x/backbone/': get: base.simpleView data, indexTpl
	meta: menu: 'x-backbone': _url: '/dotmpe/x/backbone', _label: 'Backbone'

