module.exports = 
	schema: (table) ->
		table.integer('id').primary()
		table.string('global_id').nullable().unique()
		table.datetime('date_added').notNullable()
		table.boolean('deleted')
		table.datetime('date_deleted').notNullable()
		table.text('ref').unique()

	# Create model, collection and register with Bookshelf
	define: (Base) -> 
		Location = Base.Model.extend(
			tableName: 'ids_lctr'
		)
		Locations = Base.Collection.extend(
			model: Location
		)
		Base.model('Location', Location)
		Base.collection('Locations', Locations)

