###

Load metadata for directories/files. 
Data is stored in local files, can be in different formats.

This could get quite extensive. Currently only read YAML.

Want some centralized or integrated storage (xattr, ldap)?

###

path = require 'path'
yaml = require 'js-yaml'


metafiles = [ 'main.*', 'module.*', '.meta' ]

load = ( from_path )->
	for metaf in metafiles
		path_name = path.join( from_path, metaf )
		
	

module.exports = {
	load: load
}

