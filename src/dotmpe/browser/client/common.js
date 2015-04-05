var local_dev_paths = {
  "socket.io": '/socket.io/socket.io',
  'angular': '/components/angular/angular',
  'angular-route': '/components/angular-route/angular-route',
  'angular.socket-io': '/components/angular-socket-io/socket',
  jquery: '/components/jquery/dist/jquery',
  underscore: "/components/underscore/underscore",
  "underscore.string": "/components/underscore.string/underscore.string",
  backbone: "/components/backbone/backbone",
  "backbone.localstorage": "/components/backbone.localstorage/backbone.localStorage",
  bootstrap: '/components/bootstrap/dist/js/bootstrap',
  "coffee-script": "/components/coffee-script/extras/coffee-script",
  cs: "/components/require-cs/cs",

  'app': "browser",
};
requirejs.config({
  baseUrl: '/script/',
  paths: local_dev_paths,
  shim: {
    backbone: { exports: "Backbone" },
//    etch: { deps: ['backbone'], exports: 'etch' }
    bootstrap: [ 'jquery' ],
    angular: { exports: 'angular' },
    'socket.io': [ 'angular' ],
    'angular.socket-io': [ 'angular' ],
    angularAMD: [ 'angular' ],
    'angular-route': [ 'angular' ]
  }
});
define( 'common', [ 'cs!app/main' ], function() {
});
