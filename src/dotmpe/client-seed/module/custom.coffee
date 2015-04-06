# jrc:import jquery webcomponentsjs
( $ ) ->

  layoutElementPrototype = Object.create HTMLElement.prototype
  layoutElementPrototype.createdCallback = ->
    console.log 'Custom element <layout-mpe /> created'
  layoutElementPrototype.attachedCallback = ->
  layoutElementPrototype.detachedCallback = ->
  layoutElementPrototype.attributeChangedCallback = ->
  layoutElementPrototype.testMethod = ->
    console.log 'Custom element <layout-mpe /> testMethod called'

  document.registerElement 'layout-mpe',
    'prototype': layoutElementPrototype
    #    extends: 'div'


  # Demonstrate custom element
  $(document).ready ->
    layout = document.querySelector 'layout-mpe'
    layout.testMethod()
    $layout = $('layout-mpe')
    $layout.get(0).testMethod 'test'


  # Export
  title: 'Client Seed .mpe - Custom Elements'

  prototypes:
    layout: layoutElementPrototype

