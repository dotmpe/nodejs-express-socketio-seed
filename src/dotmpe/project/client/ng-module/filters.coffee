'use strict'

# Filters 

define [ 'angular' ], (angular)->

	angular.module('dotmpe-project-ng.filters', []).
	  filter('interpolate', (version)->
		(text)->
		  String(text).replace(/\%VERSION\%/mg, version)
	  )

