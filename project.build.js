{
	appDir: 'src/dotmpe/project/client',
	baseUrl: '.',// relative to appDir
	paths: {
		app: '../client',
		jquery: 'empty:',
	//	cs: 'empty:',
	"coffee-script": "../../../../public/components/coffee-script/extras/coffee-script",
	cs: "../../../../public/components/require-cs/cs"
	},
	modules: [ 
		{
			name: 'main',
//			include: [ '' ]
		},
	],
	dir: './public/script/project',
}
