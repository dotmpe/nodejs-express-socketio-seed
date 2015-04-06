// 
// Require.js is tasked with loading the main packages.
// This is very much a work in progress, and mantained ad hoc by hand.
//

// XXX some old working paths/shims for reference:
var local_dev_paths = {
  'angular': '/components/angular/angular',
  'angular-route': '/components/angular-route/angular-route',
  'angular.socket-io': '/components/angular-socket-io/socket',
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
    'bootstrap',
    'dotmpe/client-seed/socket'
  ],

  // TODO: build paths from prerequisites gathered from modules, and with paths
  // configured in config.<env>.lib.js
  paths: {
    components: '../components',
    jquery: '/components/jquery/dist/jquery',
    "socket.io": '/socket.io/socket.io',
    bootstrap: '/components/bootstrap/dist/js/bootstrap',
    webcomponentsjs: '/components/webcomponentsjs/webcomponents',
    underscore: "/components/underscore/underscore",
    "underscore.string": "/components/underscore.string/underscore.string",
    backbone: "/components/backbone/backbone",
    "backbone.localstorage": "/components/backbone.localstorage/backbone.localStorage"
  },

  shim: {
    bootstrap: [ 'jquery' ],
  },

  // XXX manually update from make build-client output
  bundles: {
    'pkg-dotmpe-browser': [
      'dotmpe/browser/main'
    ],
    'pkg-dotmpe-client-seed': [
      'dotmpe/client-seed/index',
      'dotmpe/client-seed/navbar',
      'dotmpe/client-seed/document',
      'dotmpe/client-seed/socket',
      'dotmpe/client-seed/custom'
    ],
    'pkg-x-bookmarks': [
      'x-bookmarks/main'
    ]
  }

});

// Now defer to page to complete bootstrap
window.on_client_seed ? window.on_client_seed() : null;

