

module.exports = ( module )->

  base = module.core.base
  config = module.core.config
  config.lib.js.require_main.push '/script/client/index.js'

  # install backend
  #be = require("./backend/#{config.client_type}")( module )

  # Controller for Jade client template
  client = new base.type.Base module, 'client',
    page: title: "Client"

  route:
    base:
      all: ( req, res, next )->
        client.get req, res


