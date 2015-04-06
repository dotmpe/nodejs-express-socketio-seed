# jrc:import angularAMD angular-route ./ng-module/controllers ./ng-module/services ./ng-module/filters ./ng-module/directives
( angularAMD ) ->

  'use strict'

  # Maybe convert other version to RequireJs first
  # http://www.startersquad.com/blog/angularjs-requirejs/
  app = angular.module( 'dotmpe-project-ng', [

      'dotmpe-project-ng.controllers'
      'dotmpe-project-ng.directives'
      'dotmpe-project-ng.filters'
      'dotmpe-project-ng.services'
      'ngRoute'

      # 3rd party dependencies
      'btford.socket-io' # angular-socket-io

    ])
    .config(($routeProvider, $locationProvider) ->

      $routeProvider
        .when '/home',
          templateUrl: '/project/ng/view/home/home'
          controllerUrl: 'dotmpe-project/ng-module/controllers/home'
          navTab: 'home'
        .when('/account',
          templateUrl: '/trojan/view/account/account'
          controller: 'AccountCtrl'
        )
        .when('/account/list',
          templateUrl: '/trojan/view/account/list'
          controller: 'AccountCtrl'
        )
        .when('/post',
          templateUrl: '/trojan/view/post/post'
          controller: 'PostCtrl'
        )
        .otherwise(
          redirectTo: '/home'
        )

      # locationProvider.html5Mode(true);
      console.debug('angular client "dotmpe.project" init\'ed')
    )

  console.debug 'Bootstrapping dotmpe-project-ng'

  angularAMD.bootstrap(app)

  return app

