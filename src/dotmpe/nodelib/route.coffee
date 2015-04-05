###
Metadata to Express helpers.

###
_ = require 'lodash'

applyRoutes = (app, root, controller)->

  if !app
    console.log root, controller
    throw "Missing app"

  routes = {}
  for name, route of controller.route
    # full url
    url = [ root, name ].join('/').replace('$', ':')
    # recurse to sub-route
    if route.route
      subRoutes = applyRoutes app, url, route
      _.extend routes, subRoutes
    # apply current level
    for method in ['all', 'get', 'put', 'post', 'options', 'delete']
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
        else
          app[method] url, cb
  routes

module.exports =
  applyRoutes: applyRoutes

