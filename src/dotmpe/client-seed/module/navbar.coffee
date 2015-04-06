# jrc:import jquery
# jrc:title NavBar Autohide
# jrc:description Hides the NavBar
( $ ) ->

  navbar = null
  navbar_timer = false

  initnavbar = ->
    navbar = $('nav.navbar')
    navbar.on 'mouseover', resettimeout
    navbar.on 'mouseout', ->
      resettimeout()
      primetimeout()
    hidenavbar()

  primetimeout = -> navbar_timer = setTimeout hidenavbar, 500
  resettimeout = -> clearTimeout navbar_timer

  hidenavbar = ->
    if (navbar.is(':visible'))
      navbar.hide(200)

  shownavbar = ->
    if (!navbar.is(':visible'))
      navbar.show()

  $(document).ready ->
    $(document).on 'mousemove', (event)->
      if (event.clientY < 10)
        shownavbar()
    initnavbar()


  title: 'Client Seed .mpe - NavBar'

