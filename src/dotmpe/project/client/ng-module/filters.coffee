#jrc:import angularAMD
( angularAMD ) ->

  angular.module('dotmpe-project-ng.filters', [])
  .filter('interpolate', (version) ->
    (text) ->
      String(text).replace(/\%VERSION\%/mg, version)
    )

