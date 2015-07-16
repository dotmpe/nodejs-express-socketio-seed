#!/usr/bin/env coffee
###

Packages jade-requirejs-client sources into a bundle.

XXX: I could not get r.js -o to do anything useful, so
   wrote build.coffee to process jrc modules.

TODO:

- Scan for jade-requirejs-client modules.
  Metadata specifies build parameters, and prerequisites.
  Track prerequisites.

- Package the sources for each module into specified bundle.
  By default a bundle is created for the local module.
  But amending other bundles should be possible.
  Track bundles.

- Using config, write a Require.js main config file:
  with all prerequisites and bundles, and
  cdn/component urls/paths/map.. whatever.

###
path = require 'path'
fs = require 'fs'

_ = require 'lodash'
glob = require 'glob'
CoffeeScript = require 'coffee-script'

metadatalib = require './src/dotmpe/nodelib/metadata'
codelib = require './src/dotmpe/nodelib/code'




type = 'jade-requirejs-client/0.1'

main = ( argv ) ->

  interpreter = argv.shift()
  scriptname = argv.shift()

  packs = {}
  for arg in argv
    if not fs.existsSync arg
      console.error "No such path #{arg}"
      continue
    stats = fs.statSync arg

    if stats.isDirectory()
      mdPath = arg
    else if stats.isFile()
      mdPath = path.dirname arg

    if mdPath
      newPacks = updateModule mdPath
      _.merge packs, newPacks

    else
      console.error "Skipped #{arg}"

  # TODO: generate public/script/main.js
  if not _.isEmpty packs
    console.log 'packs = ',packs

  0

updateModule = ( dir ) ->
  #md = metadatalib.load dir
  #console.log dir, md

  jr_md = metadatalib.load dir, type
  if _.isEmpty jr_md
    console.warn "No JRC metadata in #{dir}"
    return

  #console.log 'jr', dir, jr_md

  fp = fs.openSync "public/script/#{jr_md.name}.js", 'w+'

  fs.writeSync fp, """/* build.coffee: Compiling #{jr_md.name} from #{dir} */

  """

  amdpath = path.join dir, jr_md.compile.dir

  extensions = jr_md.compile.extensions || [ 'coffee' ]

  packages = {}

  for ext in extensions
    paths = glob.sync path.join amdpath, '*.' + ext
    bundle = []
    for p in paths
      localname = path.relative amdpath, p.substring 0, p.length-ext.length-1
      name = path.join jr_md.name, localname
      bundle.push name
      #fs.writeSync fp, p, name, './'+localname
      #mdef = metadatalib.readJrcModDef jr_md, localname
      data = fs.readFileSync p, 'ascii'
      mdata = metadatalib.parseJrcHeader data
      mdef = _.defaults mdata,
        id: name
        src: p
      if ext == 'coffee'
        compiled = CoffeeScript.compile( data, bare: true ).trim()
        # even with --bare, CoffeeScript wraps JS. Remove '(' ... ');'
        mdef_body = compiled.substr( 1, compiled.length - 3 )
      else
        throw new Error "FIXME: support #{ext}"
      deps = mdef.deps || []
      for dep, i in deps
        if dep.substr(0, 2) == './'
          deps[i] = path.join jr_md.name, dep.substr(2)
      mdef_deps = JSON.stringify deps || []

      fs.writeSync fp, """/* build.coffee: src: #{mdef.src} */

      define( '#{mdef.id}', #{mdef_deps}, #{mdef_body});

      /* build.coffee: eof: #{mdef.src} */

      """

    packages[ jr_md.name ] = bundle
  packages

process.exit main process.argv
