mocklib = require './../mocks'
routelib = require '../../src/dotmpe/nodelib/route'


class MockHandler
  constructor: ( @module, @view )->
  get: ->


describe 'nodelib.route', ->

  appMock = new mocklib.AppMock()


  it """Should apply each HTTP method handler from the route objects on the
      module to the Express instance""", ->

    # see project module for new meta
    obj =
      route:
        foo:
          route:
            bar:
              get: ->
            baz:
              all: ->

    routelib.applyRoutes appMock, 'root', obj

    expect( appMock.routes ).toEqual [ 'root/foo/bar', 'root/foo/baz' ]
    expect( appMock.gets ).toBe 1
    expect( appMock.alls ).toBe 1

    appMock.reset()


  it """Should apply each HTTP method handler from the route lists on the module
      to the Express instance""", ->

    arr = route: [
        all: 'url', handler: ->
      ,
        get: 'url2', handler: ->
      ]

    routelib.applyRoutes appMock, 'root', arr

    expect( appMock.routes ).toEqual [ 'root/url', 'root/url2' ]
    expect( appMock.gets ).toBe 1
    expect( appMock.alls ).toBe 1

    appMock.reset()


  it 'Should resolve handlers with explicit template/view name', ->

    mod =
      core: base: type: Base: MockHandler
      route: foo: get: 'Base(main)'

    routelib.applyRoutes appMock, 'root', mod

    expect( appMock.cbs.length ).toBe 1
    expect( appMock.cbs[0] ).toEqual jasmine.any Function

    appMock.reset()


