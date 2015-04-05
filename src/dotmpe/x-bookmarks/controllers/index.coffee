path = require 'path'
sqlite3 = require 'sqlite3'
Bookshelf = require 'bookshelf'
warehouse = require 'warehousejs'
chalk = require 'chalk'


module.exports = (module) ->

  app = module.core.app

  # Set up a primary persisted storage
  knex = app.get('knex.main')
  if not knex
    knex = require('knex')(module.core.config.database.main)
    app.set('knex.main', knex)
  console.log(chalk.grey('Initialized main DB conn'))

  # Prepare DB connection
  SQLiteBase = Bookshelf.initialize(knex)

  Bookshelf.session = SQLiteBase

  # Load models of module
  models = require module.modelPath
  # Prepare Bookshelf.{model,collection} registries
  SQLiteBase.plugin 'registry'
  # Define and register models
  models.location.define(SQLiteBase)
  models.bookmark.define(SQLiteBase)

  # XXX Sets up second store connection ... barebone CRUD for SQLite3 records
  SqlBackend = require 'warehousejs/backend/sql'

  bookmarks = new SqlBackend
    driver: 'sqlite3'
    filename: module.core.config.database.main.connection.filename
  bookmarks.open()
  warehouse.applyRoutes app, '/data/locations', bookmarks.objectStore 'ids_lctr'
  warehouse.applyRoutes app, '/data/bookmarks', bookmarks.objectStore 'bm'

  # Return hash with handlers
  x_bookshelf = (req, res, next) ->
    Location = SQLiteBase.model('Location')
    Locations = SQLiteBase.collection('Locations')
    new Locations().query().count('id').then(
      (rs) ->
        res.render path.join(module.viewPath, 'index'),
          page: title: "Bookshelf, Knex, Warehouse testing"
          module: module
          config: module.core.config
          pkg: module.core.pkg
          menu: module.core.meta.menu
          head: module.core.config.lib
          test: rs[0]['count("id")']
    )

  route:
    'x-bookmarks':
      get: x_bookshelf

  meta:
    menu:
      bookmarks: _url: '/x-bookmarks', _label: 'Bookmarks'

