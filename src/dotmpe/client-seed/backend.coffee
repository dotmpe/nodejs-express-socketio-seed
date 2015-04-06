# Controller for Express-MVC module
#
module.exports = ( module ) ->

  app = module.core.app

  io = app.get 'io'

  io.sockets.on 'connection', (socket) ->

    sendPing = ->
      socket.emit 'ping', Date.now()

    setInterval sendPing, 5000

  route:
    client:
      get: 'Base(client)'

  meta: menu: x:
    _menu: 'X'
    client:
      _url: '/client'
      _label: 'Client Seed'

