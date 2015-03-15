###

###

_ = require 'lodash'
fs = require 'fs'
child_process = require 'child_process'

module.exports = ( module )->

	base = module.core.base
	projectDir = process.cwd()

	route:
		data:
			route:
				project:
					route:
						document:
							get: (req, res, next)->
							
								q = req.query
								_.defaults q, format: 'xml' 
								cmd = "rst2#{q.format}.py '#{q.docpath}.rst'"

								if q.format == 'source'
									res.type 'text'
									res.write fs.readFileSync "#{q.docpath}.rst"
									res.end()

								else
								
									child_process.exec cmd, (error, stdout, stderr)->
										if error
											res.type('text/plain')
											res.status(500)
											res.write("exec error: "+error)
											res.end()
										else if q.format == 'xml'
											res.type 'xml'
											res.write(stdout)
											res.end()
										else if q.format == 'html'
											res.type 'html'
											res.write(stdout)
											res.end()
										else if q.format == 'pseudoxml'
											res.type 'text/plain'
											res.write(stdout)
											res.end()

