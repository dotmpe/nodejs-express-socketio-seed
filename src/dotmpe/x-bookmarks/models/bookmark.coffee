module.exports =

  # Define table schema with knex
  schema: (table) ->
    table.text('descr').nullable()
    table.timestamps() # created_at, updated_at
    table.string('tags').nullable()
    table.uuid('location')
      .references('id')
      .inTable('locators')

  # Create model, collection and register with Bookshelf
  define: (Base) ->
    Bookmark = Base.Model.extend(
      tableName: 'bm'
    )
    Bookmarks = Base.Collection.extend(
      model: Bookmark
    )
    Base.model('Bookmark', Bookmark)
    Base.collection('Bookmarks', Bookmarks)

