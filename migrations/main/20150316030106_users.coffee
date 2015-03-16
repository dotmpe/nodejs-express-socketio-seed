userTableName = 'user'
userTableSchema = (table)->
	table.increments('id').primary()
	#table.uuid('id').primary()
	table.string('name')
	table.string('email')
	table.string('username')
	table.string('provider')
	table.string('hashed_password')
	table.string('salt')
	table.string('authToken')

	table.text('twitter')
	table.text('facebook')
	table.text('github')
	table.text('google')
	table.text('linkedin')


exports.up = (knex, Promise) ->
	return Promise.all([
		knex.schema.createTable userTableName, userTableSchema
	])

exports.down = (knex, Promise) ->
	return Promise.all([
		knex.schema.dropTable userTableName
	])

