###
Metadata to Express helpers.

###
_ = require 'lodash'


# XXX Init one-off controller instance to handle str-spec callback..
resolveHandler = (module, cb) ->

  if cb.match /^[a-z0-9]+\([a-z-]*\)$/i
    [ type, name ] = cb.substr( 0, cb.length - 1 ).split('(')
    core = module.core
    new core.base.type[ type ]( module, name )


HTTP_methods = "all get put post head options delete".split ' '

applyRoutes = (app, root, module) ->

  if !app
    throw new Error "Missing app"

  routes = {}

  # add routes from metadata obj list
  if _.isArray module.route
    for route in module.route
      for method in HTTP_methods
        if not route.hasOwnProperty method
          continue
        if !_.isArray( route[method] )
          routes = [ route[method] ]
        else
          routes = route[method]
        for pattern in routes
          url = [ root, pattern ].join('/').replace('$', ':')
          # Apply to Express; ie. app.get( url, callback )
          cb = route.handler
          if _.isArray cb
            app[method].apply app, [ url, cb... ]
          else if _.isString cb
            h = resolveHandler( module, cb )
            throw new Error("No such handler type #{cb}") if ! _.isObject h
            throw new Error(
              "Handler for type #{cb} has no method #{method}"
            ) if ! _.isObject h[method]
            app[method] url, _.bind h[method], h
          else
            app[method] url, cb

  # recursively add simple object metadata scheme
  else if _.isObject module.route

    for name, route of module.route
      # full url
      url = [ root, name ].join('/').replace('$', ':')
      # recurse to sub-route
      if route.route
        subRoutes = applyRoutes app, url, route
        _.extend routes, subRoutes
      # apply current level
      for method in HTTP_methods
        cb = route[method]
        if cb
          #console.log url, method
          # Track all routes?
          if url not of routes
            routes[url] = {}
          if method of routes[url]
            console.error "Already routed: ", method, url
          routes[url][method] = cb
          # Apply to Express; ie. app.get( url, callback )
          if _.isArray cb
            app[method].apply app, [ url, cb... ]
          else if _.isString cb
            h = resolveHandler( module, cb )
            app[method] url, _.bind h[method], h
          else
            app[method] url, cb

  routes


module.exports =

  applyRoutes: applyRoutes

