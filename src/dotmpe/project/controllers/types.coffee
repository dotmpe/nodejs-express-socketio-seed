_ = require 'lodash'


module.exports = ( base )->


  class Project extends base.type.Base

    all: ( req, res, next ) ->
      @get( req, res )


  class DocView extends base.type.Base

    all: ( req, res, next ) ->

      context = _.bind @getContext, @
      context.req = req

      handler = base.simpleView context, @template
      handler req, res, next


  Project: Project
  DocView: DocView

