global.__approot = __dirname
#require('./config/config'){ rootPath: __dirname }

module.exports =

	development: require('./config/knex-migrate')('development')


