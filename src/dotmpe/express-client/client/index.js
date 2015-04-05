var local_dev_paths = {
  jquery: '/components/jquery/dist/jquery',
  underscore: '/components/underscore/underscore',
  //'socket.io': '/socket.io/socket.io',
  bootstrap: '/components/bootstrap/dist/js/bootstrap',
  'coffee-script': '/components/coffee-script/extras/coffee-script',
  cs: '/components/require-cs/cs',
};
requirejs.config({
  baseUrl: '/script/',
  paths: local_dev_paths,
  shim: {
    bootstrap: [ 'jquery' ],
  },
  deps: [
    'cs!client/navbar',
    'cs!client/document',
    'cs!client/socket',
  ]
});
