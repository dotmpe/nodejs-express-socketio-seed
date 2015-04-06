// 
// Require.js main file
//

// XXX some old working paths/shims for reference:
var local_dev_paths = {
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
  cs: "/components/require-cs/cs"
};
var shim = {
  backbone: { exports: "Backbone" },
//  etch: { deps: ['backbone'], exports: 'etch' }
  bootstrap: [ 'jquery' ],
  angular: { exports: 'angular' },
  'socket.io': [ 'angular' ],
  'angular.socket-io': [ 'angular' ],
  angularAMD: [ 'angular' ],
  'angular-route': [ 'angular' ]
};

requirejs.config({
  baseUrl: '/script',
  dir: '.',

  // TODO: switch deps based on page, some sort of dynamic injection..
  deps: [
    'dotmpe/client-seed/index',
    'dotmpe/browser/main'
  ],

  // TODO: build paths from prerequisites gathered from modules, and with paths
  // configured in config.<env>.lib.js
  paths: {
    components: '../components',
    jquery: '/components/jquery/dist/jquery',
    "socket.io": '/socket.io/socket.io',
    webcomponentsjs: '/components/webcomponentsjs/webcomponents'
  },

  // XXX manually update from make build-client output
  bundles: {
    'dotmpe/browser': [
      'dotmpe/browser/main'
    ],
    'dotmpe/client-seed': [
      'dotmpe/client-seed/index',
      'dotmpe/client-seed/navbar',
      'dotmpe/client-seed/document',
      'dotmpe/client-seed/socket',
      'dotmpe/client-seed/custom'
    ]
  }

});
