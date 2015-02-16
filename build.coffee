
# Frontend built
require("modulr").build("x-nodejs-htdocs", {
		environment: 'dev' # always build dev-code and add sourceURL
		paths: ['./lib', './vendor']
		# cwd:root: ['./public/script']
		lazyEval: ['x-nodejs-htdocs']
		minify: true
		minifyIdentifiers: true,
		resolveIdentifiers: true
	}, (err, result) ->

		if err
			console.error err
			throw err
		else
			require('fs')
				.writeFileSync('public/script/app-modulr-main.js', result.output, 'utf8')

			console.log "Build done"
)

