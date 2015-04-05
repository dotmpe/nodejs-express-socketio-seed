module.exports = ( config )->

  for env in config.envs
    config[env].modules.push 'dotmpe/express-client'

    config[env].lib.js.require_main.push '/script/client/index.js'

    config[env].client = index: 
      deps: [
        'cs!express-client/navbar'
        'cs!express-client/document'
        'cs!express-client/socket'
      ]
      paths:
        'express-client': './client'
        jquery: '/components/jquery/dist/jquery'
        underscore: '/components/underscore/underscore'
        #'socket.io': '/socket.io/socket.io'
        bootstrap: '/components/bootstrap/dist/js/bootstrap'
        'coffee-script': '/components/coffee-script/extras/coffee-script'
        cs: '/components/require-cs/cs'

  client: null

