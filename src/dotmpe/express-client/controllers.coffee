

module.exports = ( module )->

	base = module.core.base

	# install backend
	#be = require("./backend/#{config.client_type}")( module )

	# Controller for Jade client template
	client = new base.type.Base module, 'client',
		page: title: "Client"

	route:
		base:
			all: ( req, res, next)->
				client.get req, res


