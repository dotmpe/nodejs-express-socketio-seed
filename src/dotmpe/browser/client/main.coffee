# jrc:export dotmpe/browser/main
# jrc:import ../client-seed/index jquery webcomponentsjs
( client, $ ) ->

  console.log 'Browser main: registering custom element <browser-mpe /> '

  # Create the prototype for the browser element
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


  # register the custom element
  document.registerElement 'browser-mpe',
    'prototype': browserElementPrototype
    #    extends: 'div'


  # demonstrate custom element
  $(document).ready ->

    browser = document.querySelector 'browser-mpe'
    #browser.testBrowser()

    $browser = $('browser-mpe')
    #$browser.get(0).testBrowser 'test'


