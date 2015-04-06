_ = require 'lodash'
fs = require 'fs'
path = require 'path'
jade = require 'jade'


tplDir = [
  '.', 'src', 'dotmpe', 'express-seed', 'views', 'site',
].join(path.sep)

tplPath = require.resolve path.join tplPath, 'about.jade'

tpl = jade.compileFile tplPath
#console.log tplPath, tpl

str = fs.readFileSync tplPath, 'utf8'

opts =
  name: 'my-jade-template'
  filename: tplPath

parser = new jade.Parser str, tplPath, opts
block = parser.parse()
console.log 'block', block

jade.utils.walkAST block, ( node ) ->
  console.log node.line || '-', node.name || '<node>',
    node.nodes && node.nodes.length || 0
#compiler = new jade.Compiler tokens, opts
#js = compiler.compile()
#console.log 'js', js

dir = path.dirname tplPath
for dep in tpl.dependencies
  console.log path.relative dir, dep

module.exports =
  fn: tplPath
  tpl: tpl
