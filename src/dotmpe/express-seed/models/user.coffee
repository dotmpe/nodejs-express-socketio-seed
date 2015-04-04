###
Knex SQL schema and Bookshelf model/collection for User entities
###
module.exports =
  schema: (table) ->
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

  define: (Base) ->
    crypto = require('crypto')
    User = Base.Model.extend(
      tableName: 'user'
      authenticate: (plaintext) ->
        @encryptPassword(plaintext) == @hashed_password
      makeSalt: ->
        Math.round((new Date().valueOf() * Math.random())) + ''
      encryptPassword: (password) ->
        try
          crypto.createHmac('sha1', @salt).update(password).digest('hex')
        catch err
          ''
      password: (password) ->
        if password
          @_password = password
          @salt = @makeSalt()
          @hashed_password = @encryptPassword password
    )
    Users = Base.Collection.extend(
      model: User
    )
    # register with
    Base.model('User', User)
    Base.collection('Users', Users)

    User: User
    Users: Users


