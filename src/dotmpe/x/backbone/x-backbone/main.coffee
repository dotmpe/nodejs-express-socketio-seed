
_ = require 'lodash'
fs = require 'fs'
path = require 'path'
jade = require 'jade'


indexTpl = jade.compileFile require.resolve './index.jade'

module.exports = (module)->

	data = ()->
		page: title: "Backbone", summary: "Testing Backbone"

	base = module.core.base

	_.merge module.core.base,
		route: 'dotmpe/x/backbone/': get: base.simpleView data, indexTpl

