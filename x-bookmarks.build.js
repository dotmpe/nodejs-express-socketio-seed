{
	appDir: 'src/dotmpe/x-bookmarks/client',
	baseUrl: '.',// relative to appDir
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

