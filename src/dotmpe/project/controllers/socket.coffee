module.exports = (socket) ->

  socket.emit 'send:message',
    payload: 'Contents'

  socket.emit 'send:name',
    name: 'Bob'

  sendTime = ->
      socket.emit 'send:time',
        time: new Date().toString()
  setInterval sendTime, 1000

  sendPing = ->
    socket.emit 'ping', Date.now()
  setInterval sendPing, 5000

