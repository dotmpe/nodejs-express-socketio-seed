path = require 'path'
sqlite3 = require 'sqlite3'
Bookshelf = require 'bookshelf'

module.exports = (module)->

	# Prepare DB connection
	SQLiteBase = Bookshelf.initialize(
		client: 'sqlite'
		connection:
			#filename: './bookmarks.sqlite3.db'
			filename: '/Users/berend/htdocs/.cllct/bms.sqlite'
	)
	Bookshelf.session = SQLiteBase
	# Load models of module
	models = require module.modelPath
	# Prepare Bookshelf.{model,collection} registries
	SQLiteBase.plugin 'registry'
	# Define and register models
	models.location.define(SQLiteBase)
	models.bookmark.define(SQLiteBase)

	# Return hash with handlers
	x_bookshelf = (req, res, next)->
		Location = SQLiteBase.model('Location')
		Locations = SQLiteBase.collection('Locations')
		new Locations().query().count('id').then(
			(rs) ->
				res.render path.join(module.viewPath, 'index'),
					test: rs[0]['count("id")']
		)

	route:
		'x-bookmarks':
			get: x_bookshelf

