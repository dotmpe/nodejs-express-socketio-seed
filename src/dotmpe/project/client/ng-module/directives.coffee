'use strict'

define ['angular'], (angular)->
	angular.module('dotmpe-project-ng.directives', [])
		.directive('appVersion', (version)->
			(scope, elm, attrs) ->
				elm.text(version)
		)

