var local_dev_paths = {
  app: './project',
  'dotmpe-project': './project',
  jquery: '/components/jquery/dist/jquery',
  underscore: '/components/underscore/underscore',
  'socket.io': '/socket.io/socket.io',
  'angular': '/components/angular/angular',
  'angular-route': '/components/angular-route/angular-route',
  'angular.socket-io': '/components/angular-socket-io/socket',
  bootstrap: '/components/bootstrap/dist/js/bootstrap',
  'coffee-script': '/components/coffee-script/extras/coffee-script',
  cs: '/components/require-cs/cs',
  'angularAMD': '/components/angularAMD/angularAMD',

};
requirejs.config({
  baseUrl: '/script/',
  paths: local_dev_paths,
  shim: { 
    bootstrap: [ 'jquery' ],
    angular: { exports: 'angular' },
    'socket.io': [ 'angular' ],
    'angular.socket-io': [ 'angular' ],
    angularAMD: [ 'angular' ],
    'angular-route': [ 'angular' ]
  },
  deps: [
    'cs!dotmpe-project/document',
    'cs!dotmpe-project/ng'
  ]
});
//require(['app/document']);
