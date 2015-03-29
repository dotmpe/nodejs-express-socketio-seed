#jslint node: true 
#global define 
define([
	'trojan-cs/app', 'bootstrap'
], (app)->

	app.register.controller "navMenuController", [
		'$scope', '$route', 'SiteName', '$window', '$location', 
		($scope, $route, SiteName, $window, $location)->
			console.log 'navMenuController', $scope

			tab_name = $route.current.navTab
			ga_path = SiteName + $location.path()
					
			$scope.isTabActive = (tabName)->
				if (tabName === tab_name) {
					return "active"
				}

			#console.log("Sending to GA: " + ga_path);
					#$window._gaq.push(['_trackPageview', ga_path]);

		]

	app.register.directive 'navMenu', ()->
		restrict: 'A',
		controller: 'navMenuController',
		templateUrl: '/project/ng/view/includes/base-menu',
		#templateUrl: '/script/ng-trojan/directives/templates/navMenu.html'


)

