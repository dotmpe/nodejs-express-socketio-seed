glob = require 'glob'
fs = require 'fs'
path = require 'path'
_ = require 'lodash'


global.__noderoot = path.dirname __dirname

config = require './config-example'
config.envs = [
  'test'
  'production'
  'development'
]

if fs.existsSync __dirname + '/config-keys.coffee'
  keys = require( './config-keys' ) ( config )
  _.merge config, keys

paths = glob.sync __dirname + '/config.*.coffee'
for fn in paths
  _.merge config, require( fn )( config )

config.env = process.env.NODE_ENV || 'development'

module.exports = config

