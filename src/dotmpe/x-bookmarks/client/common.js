local_dev_paths = {
	app: 'x-bookmarks',
	jquery: '../components/jquery/dist/jquery',
	underscore: "/components/underscore/underscore",
	"underscore.string": "/components/underscore.string/underscore.string",
	backbone: "/components/backbone/backbone",
	"backbone.localstorage": "/components/backbone.localstorage/backbone.localStorage",
	bootstrap: "/components/bootstrap/dist/js/bootstrap",
	"coffee-script": "../components/coffee-script/extras/coffee-script",
	cs: "../components/require-cs/cs"
};
requirejs.config({
	baseUrl: '/script/',
	paths: local_dev_paths,
	shim: {
		backbone: { exports: "Backbone" },
//		etch: { deps: ['backbone'], exports: 'etch' }
	},
});
define('common', [], function() {
});
