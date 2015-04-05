require [
], ->

  socket = null
  reset = null
  heartbeat = null
  session_start = null
  reload_after = null

  init = ->

    console.log 'Initializing Socket.IO client'
    socket = io.connect()

    if window.location.hash
      reload_after = parseInt window.location.hash.substr(1)
      window.location.hash = ''

    socket.on 'connect', ->
      session_start = Date.now()
      if reload_after
        secs = (session_start - reload_after) / 1000
        console.log "Reconnected #{secs} sec later"
      else
        console.log 'Connected'

      # anticipate server reset for file-reload; reload client too
      if reset
        window.location.hash = heartbeat
        window.location.reload()

  # coffeelint: disable=max_line_length
  # TODO announce, handshake; (re)set/update any session based client components
  # coffeelint: enable=max_line_length
      # should validate client (meta)data
      socket.send('hi')

    socket.on 'disconnect', ->
      secs = ( Date.now() - session_start ) / 1000
      console.warn "Disconnected from server @ #{secs} sec"
      reset = true

    # server sends ping each 5 seconds
    socket.on 'ping', ( timestamp )->
      ms = Date.now() - timestamp
      console.log "server @ #{timestamp} ms, latency #{ms} ms"
      if reload_after
        secs = (timestamp - reload_after) / 1000
        console.log "server downtime #{secs} sec"
        reload_after = null
      heartbeat = timestamp

    # XXX some client side socket io examples
    socket.on 'message', (msg)->
      console.log 'message from server: '+msg

    socket.on 'test', (data)->
      console.log [ 'socket.io test', data ]

  init()


