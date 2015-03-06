fs = require 'fs'


# Frontend built
require("modulr").build("x-modulr", {
		environment: 'dev' # always build dev-code and add sourceURL
		paths: [ './lib', './vendor', './src/js/dotmpe/' ]
		# cwd:root: ['./public/script']
		lazyEval: [ 'x-modulr', ]
		minify: true
		minifyIdentifiers: true,
		resolveIdentifiers: true
	}, (err, result) ->

		if err
			console.error err
			throw err
		else
			fs.writeFileSync('public/script/pkg-x-modulr.js', result.output, 'utf8')

			console.log "Build done"
)


require("modulr").build("dotmpe-project", {

		environment: 'dev' # always build dev-code and add sourceURL
		paths: [ './lib', './vendor', './src/js/dotmpe/' ]
		lazyEval: [ 'dotmpe-project', 'project' ]
		minify: true
		minifyIdentifiers: true,
		resolveIdentifiers: true

	}, (err, result) ->

		if err
			console.error err
			throw err
		else
			fs.writeFileSync('public/script/pkg-dotmpe-project.js', result.output, 'utf8')

			console.log "Build done"
)


require("modulr").build("dotmpe-x-backbone", {

		environment: 'dev' # always build dev-code and add sourceURL
		paths: [ './lib', './vendor', './src/dotmpe/x/backbone/client' ]
		lazyEval: true # all modules are lazy evaluated
		#minify: true
		minifyIdentifiers: true,
		resolveIdentifiers: true

	}, (err, result) ->

		if err
			console.error err
			throw err
		else
			fs.writeFileSync('public/script/pkg-dotmpe-x-backbone.js', result.output, 'utf8')

			console.log "Build done"
)

