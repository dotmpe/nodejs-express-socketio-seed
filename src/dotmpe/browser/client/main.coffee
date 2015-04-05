browserElementPrototype = Object.create HTMLElement.prototype
browserElementPrototype.createdCallback = ->
  console.log arguments
browserElementPrototype.attachedCallback = ->
  console.log arguments
browserElementPrototype.detachedCallback = ->
  console.log arguments
browserElementPrototype.attributeChangedCallback = ->
  console.log arguments
browserElementPrototype.testBrowser = ->

require [
], ->

  console.log 'Browser main'

  document.registerElement 'browser-mpe',
    'prototype': browserElementPrototype
    #    extends: 'div'

  $(document).ready ->

    browser = document.querySelector 'browser-mpe'
    #browser.testBrowser()

    $browser = $('browser-mpe')
    #$browser.get(0).testBrowser 'test'


