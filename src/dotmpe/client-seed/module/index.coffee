# jrc:import ./document ./socket ./custom
( doc, socket, custom ) ->

  console.log 'jrc client index', arguments

  title: 'Client Index'
  modules: [ doc, socket, custom ]

