###

Load metadata for directories/files. 
Data is stored in local files, can be in different formats.

This could get quite extensive. Currently only read YAML.

Want some centralized or integrated storage (xattr, ldap)?

###

path = require 'path'
fs = require 'fs'
yaml = require 'js-yaml'
_ = require 'underscore'


typeIsArray = Array.isArray || ( value ) -> return {}.toString.call( value ) is '[object Array]'

# TODO: support various directory formats
#metafiles = [ 'main.*', 'module.*', '.meta' ]
metafiles = [ 'main.meta', 'module.meta', '.meta' ]

load = ( from_path )->
	for metaf in metafiles
		metap = path.join( from_path, metaf )
		if fs.existsSync metap
			return yaml.safeLoad fs.readFileSync metap, 'utf8'

# Parse, fetch and return MVC metadata for module
resolve_mvc_meta = ( from_path, meta )->

	version = meta.type.split('/')[1]
	meta.path = path
	meta.ext_version = version

	if not meta.components
		meta.components = [ 'models', 'views', 'controllers' ]

	for compname in meta.components
		comppath = path.join( from_path, compname )
		pathprop = compname.substring(0, compname.length-1) + 'Path'
		meta[ pathprop ] = comppath

	#for compname in meta.components
	#	compidx = require comppath

	#	if typeIsArray( compidx )
	#		compcbs = compidx
	#	else
	#		compcbs = [ compidx ]

	#	comps = []
	#	for compcb in compcbs
	#		if _.isFunction compcb
	#			comps.push compcb meta
	#		else
	#			comps.push compcb

	#	#meta[ compname ] = comps

	meta

module.exports = {
	load: load
	resolve_mvc_meta: resolve_mvc_meta
}

