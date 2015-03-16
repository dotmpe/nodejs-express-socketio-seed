require(['./common'], function() {

	console.log('x-bookmarks main');

	require(['jquery'], function($) {
		console.log('jq');
	});

	require(["cs!app/x-bookmarks-main"]);

});
