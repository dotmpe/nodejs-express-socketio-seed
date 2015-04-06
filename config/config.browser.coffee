_ = require 'lodash'

paths =
  "socket.io": '/socket.io/socket.io'
  'angular': '/components/angular/angular'
  'angular-route': '/components/angular-route/angular-route'
  'angular.socket-io': '/components/angular-socket-io/socket'
  jquery: '/components/jquery/dist/jquery'
  underscore: "/components/underscore/underscore"
  "underscore.string": "/components/underscore.string/underscore.string"
  backbone: "/components/backbone/backbone"
  # coffeelint: disable=max_line_length
  "backbone.localstorage": "/components/backbone.localstorage/backbone.localStorage"
  # coffeelint: enable=max_line_length
  bootstrap: '/components/bootstrap/dist/js/bootstrap'
  "coffee-script": "/components/coffee-script/extras/coffee-script"
  cs: "/components/require-cs/cs"


module.exports = ( config )->

  for env in config.envs
    config[env].modules.push 'dotmpe/express-client'

    # XXX add to client/index..
    index = config[env].client.index || deps: [], paths: {}
    index.deps.push 'cs!browser/main'
    _.merge index.paths, paths
    config[env].client.index = index

  ###
    config[env].lib.js.require_main.push '/script/client/browser.js'

    config[env].client = browser:
      deps: [
        'cs!browser/main'
      ]
      paths:
  ###

  client: null


