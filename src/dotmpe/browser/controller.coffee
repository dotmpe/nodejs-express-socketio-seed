_ = require 'lodash'

module.exports = ( module )->

	base = module.core.base

	class Browser extends base.type.Base
		getContext: ()->
			ctx = super
			ctx.head.js.r_main = "/script/browser/main.js"
			ctx

	browser = new Browser module, 'main', {}

	route: browser: get: _.bind browser.get, browser
	meta: menu: browser: _url: '/browser', _label: 'Browser'


