// TODO http://backbonetutorials.com/organizing-backbone-using-modules/
// ({

	baseUrl: "./src/dotmpe/x/backbone/client/",
//	appDir: "./src/dotmpe/x/backbone/client",
//	baseUrl: '',//public/script/',
  dir: 'public/script/x-backbone/client/',
	paths: {
//    jquery: "empty:",
		jquery: "../../../../../public/components/jquery/dist/jquery",
	      //cdnjs.cloudflare.com/ajax/libs/jquery/2.0.3/jquery.min",
		//jqueryui: "//cdnjs.cloudflare.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min",
		//backbone: "//cdnjs.cloudflare.com/ajax/libs/backbone.js/1.1.2/backbone-min"
	},
	modules: [

		{ name: 'main' }

	],

})
