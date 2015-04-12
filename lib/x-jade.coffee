os = require 'os'
fs = require 'fs'
path = require 'path'

_ = require 'lodash'
jade = require 'jade'
chalk = require 'chalk'


htmlstd = """html head meta link script title
body div span h1 h2 h3 h4 h5 h6 p span
table thead th tbody tr td
ol ul li dl dt dd
form button input label select option
iframe b a""".replace( /[\s\t\n\r]+/gm, ' ' ).trim().split(' ')
#.replace( os.EOL, ' ' ).split ' '


main = ( argv ) ->

  interpreter = argv.shift()
  scriptname = argv.shift()

  if argv.length
    tplPath = argv.shift()
  else
    tplDir = [
      '..', 'src', 'dotmpe', 'express-seed', 'views', 'site',
    ].join(path.sep)

    tplPath = require.resolve path.join tplDir, 'about.jade'

    tplPath = require.resolve '../src/dotmpe/project/views/docs.jade'

  tpl = jade.compileFile tplPath
  #console.log tplPath, tpl

  str = fs.readFileSync tplPath, 'utf8'

  opts =
    name: 'my-jade-template'
    filename: tplPath

  parser = new jade.Parser str, tplPath, opts
  block = parser.parse()
  #console.log 'block', block

  tags = []
  names = []
  jade.utils.walkAST block, ( node ) ->
    if node.constructor.name == 'Tag'
      if node.name in htmlstd
        return
      if node.name not in tags
        tags.push node.name
    name = node.name || '<node>'
    if name
      if name not in names
        names.push name

      #console.log node.line || '-', name,
      #  node.nodes && node.nodes.length || 0
  #compiler = new jade.Compiler tokens, opts
  #js = compiler.compile()
  #console.log 'js', js

  dir = path.dirname tplPath
  console.log chalk.blue( 'Dependencies' )
  for dep in tpl.dependencies
    console.log path.relative dir, dep

  console.log chalk.blue( 'custom-elements:' ), chalk.yellow tags.join ' '

  module.exports =
    fn: tplPath
    tpl: tpl

  0

process.exit main process.argv

