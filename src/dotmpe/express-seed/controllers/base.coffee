###
Base utils/classes to adapt HTTP requests to resource representations.
Basicly some template handing right now. 

Would rename or move current classes to types more specific to 
HTML client resources later. 
###
_ = require 'lodash'
path = require 'path'
jade = require 'jade'


util = {

  # redirect generator
  redirect: (path) ->
    (req, res) ->
      res.redirect(path)

  # variables used in the current Jade template setup
  basicContext: ( core ) ->
    # view:includes/head
    page: title: 'Title'
    core: core
    app: core.app
    pkg: core.pkg
    config: core.config
    head: core.config.lib
    # view:includes/header
    menu: core.meta.menu
    modules: [
      name: 'Mod A'
    ]
    isActive: ->
    # view:includes/messages
    #info: [
    #  "Info!"
    #]
    #errors: [
    #  "Error!"
    #]
    #success: [
    #  "Success!"
    #]
    #warning: [
    #  "Warning!"
    #]

  compileTemplate: ( name, component ) ->
    tplPath = require.resolve path.join component.viewPath, "#{name}.jade"
    jade.compileFile tplPath

  # Generates a route handler
  simpleView: (data, template_cb) ->
    (req, res, next) ->
      if data && _.isFunction data
        data = data()
      res.write( template_cb( data ) )
      res.end()

  # Generates a route handler using the Express view renderer
  simpleExpressView: (name, getContext) ->
    (req, res, next) ->
      data = if getContext then getContext(req, res) else {}
      if not data
        console.warn "No data for #{name}"
      res.render( name, data )
}

#Function::property = (prop, desc) ->
#  Object.defineProperty @prototype, prop, desc


class Controller

  ###
  Server handler base class for specific resource representations.
  ###

  constructor: (core) ->
    @component = core
    if core.core
      @module = core
      @core = @module.core
    else
      @core = core


class Base extends Controller

  ###
  Base accumulates a context, available for the template named by view.
  It offers a simple get method and uses base.simpleView to do the actual rendering.
  No compilation. Also no other assumptions about any specific resource.
  TODO: may want to set some content type sometimes.
  ###

  constructor: (core, @view, @seed) ->
    super core
    @viewPath = path.join @component.viewPath, @view
    @template = jade.compileFile "#{@viewPath}.jade"

  getContext: ->
    if not @core
      throw new Error "Error"
    @view_vars =
      # view:includes/head
      page:
        title: 'Title'
      core: @core
      app: @core.config.app
      pkg: @core.pkg
      head: @core.config.lib
      # view:includes/header
      menu: @core.meta.menu
      modules: [
        name: 'Mod A'
      ]
      isActive: ->
      # view:includes/messages
      #info: [
      #  "Info!"
      #]
      #errors: [
      #  "Error!"
      #]
      #success: [
      #  "Success!"
      #]
      #warning: [
      #  "Warning!"
      #]
    x = _.extend {},
      #@view_vars,
      util.basicContext @core,
      @seed
    return x

  # Static methods
  @init: ( core, type=Controller, opts ) ->
    new type _.defaults opts, core: core

  get: ( req, res, next ) ->
    context = _.bind @getContext, @
    browserHandler = util.simpleView context, @template
    browserHandler req, res, next


module.exports = ( core ) ->

  _.merge core.base, util,
    type:
      Controller: Controller
      Base: Base

  {}


