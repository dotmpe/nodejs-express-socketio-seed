# jrc:import jquery webcomponentsjs
( $ ) ->

  console.log 'Layout main'

  layoutElementPrototype = Object.create HTMLElement.prototype
  layoutElementPrototype.createdCallback = ->
    console.log arguments
  layoutElementPrototype.attachedCallback = ->
    console.log arguments
  layoutElementPrototype.detachedCallback = ->
    console.log arguments
  layoutElementPrototype.attributeChangedCallback = ->
    console.log arguments
  layoutElementPrototype.testBrowser = ->

  document.registerElement 'layout-mpe',
    'prototype': layoutElementPrototype
    #    extends: 'div'

  $(document).ready ->

    layout = document.querySelector 'layout-mpe'
    #layout.testBrowser()

    $layout = $('layout-mpe')
    #$layout.get(0).testBrowser 'test'

  title: 'Client Seed .mpe - Custom Elements'

