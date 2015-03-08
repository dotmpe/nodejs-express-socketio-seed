
schema = (table) ->
	table.text('descr').nullable()
	table.timestamps() # created_at, updated_at
	table.string('tags').nullable()
	table.uuid('location')
		.references('id')
		.inTable('locators')

exports.up = (knex, Promise) ->
	return Promise.all([
		knex.schema.createTable 'bm', schema
	])

exports.down = (knex, Promise) ->
	return Promise.all([
		knex.schema.dropTable 'bm'
	])



