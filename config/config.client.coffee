_ = require 'lodash'

module.exports = ( config )->

  for env in config.envs
    config[env].modules.push 'dotmpe/express-client'

    config[env].lib.js.require_main.push '/script/dotmpe-client-seed.require.js'
    #config[env].lib.js.require_main.push '/script/client/index.js'

    #index = config[env].client.index || deps: [], paths: {}
    #index.deps = _.union index.deps, [
    #    'cs!express-client/navbar'
    #    'cs!express-client/document'
    #    'cs!express-client/socket'
    #    'cs!express-client/custom'
    #  ]
    #_.merge index.paths,
    #  'express-client': './client'
    #  jquery: '/components/jquery/dist/jquery'
    #  underscore: '/components/underscore/underscore'
    #  #'socket.io': '/socket.io/socket.io'
    #  bootstrap: '/components/bootstrap/dist/js/bootstrap'
    #  'coffee-script': '/components/coffee-script/extras/coffee-script'
    #  cs: '/components/require-cs/cs'
    #config[env].client.index = index

  client: null

