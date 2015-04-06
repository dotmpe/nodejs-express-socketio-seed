# jrc:import ./document ./navbar ./socket ./custom
( doc, nav, socket, custom ) ->

  console.log 'jrc client index', arguments

  title: 'Client Index'
  modules: [ doc, nav, socket, custom ]


