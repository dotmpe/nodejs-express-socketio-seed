{
	appDir: 'src/dotmpe/x-bookmarks/client',

	baseUrl: '.',//./../../../public/script/x-bookmarks', // relative to appDir
	paths: {
		app: '../app',
		jquery: 'empty:',
	},
	modules: [ 
		{
			name: './common',
		},{
			name: 'main',
			exclude: ['./common']
		},
	],
	dir: './public/script/x-bookmarks',
}

