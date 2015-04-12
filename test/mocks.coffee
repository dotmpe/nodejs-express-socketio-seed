

class AppMock

  constructor: ->
    @reset()

  reset: (
    @gets=0, @puts=0, @posts=0, @alls=0,
    @heads=0, @deletes=0, @routes = [],
    @cbs = []
  ) ->

  get: ( url, cb ) ->
    @routes.push url
    @gets += 1
    @cbs.push cb

  post: ( url, cb ) ->
    @routes.push url
    @posts += 1

  all: ( url, cb ) ->
    @routes.push url
    @alls += 1

  head: ( url, cb ) ->
    @routes.push url
    @heads += 1
  put: -> @puts += 1
  delete: -> @deletes += 1
  options: -> @optionss += 1


module.exports =
  AppMock: AppMock

