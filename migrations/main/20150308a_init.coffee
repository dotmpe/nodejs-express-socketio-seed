
bm_schema = (table) ->
	table.text('descr').nullable()
	table.timestamps() # created_at, updated_at
	table.string('tags').nullable()
	table.uuid('location')
		.references('id')
		.inTable('ids_lctr')

ids_lctr_schema = (table) ->
	table.integer('id').primary()
	table.string('global_id').nullable().unique()
	table.datetime('date_added').notNullable()
	table.boolean('deleted').default(false)
	table.boolean('private')
	table.datetime('date_deleted').nullable()
	table.text('href').unique()

exports.up = (knex, Promise) ->
	return Promise.all([
		knex.schema.createTable 'bm', bm_schema
		knex.schema.createTable 'ids_lctr', ids_lctr_schema
	])

exports.down = (knex, Promise) ->
	return Promise.all([
		knex.schema.dropTable 'bm'
		knex.schema.dropTable 'ids_lctr'
	])



