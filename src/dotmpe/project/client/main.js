local_dev_paths = {
	app: 'project',
	jquery: '../components/jquery/dist/jquery',
	underscore: "/components/underscore/underscore",
	"coffee-script": "../components/coffee-script/extras/coffee-script",
	cs: "../components/require-cs/cs"
};
requirejs.config({
	baseUrl: '/script/',
	paths: local_dev_paths,
});
require(["cs!app/document"]);
