global.__noderoot = __dirname
config = require './config/config'


module.exports =

  development: config[ config.env ].database.main


