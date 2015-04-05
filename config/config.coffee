config = require './config-example'

_ = require 'lodash'
keys = require( './config-keys' ) ( config )
_.merge config, keys

module.exports = config

