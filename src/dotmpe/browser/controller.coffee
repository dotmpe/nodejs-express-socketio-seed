_ = require 'lodash'

module.exports = ( module )->

	base = module.core.base

	browser = new base.type.Base module, 'main', {}

	route: browser: get: _.bind browser.get, browser

