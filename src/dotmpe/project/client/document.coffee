require ['jquery'], ($) ->

  console.log 'Document: Coffee Time'

  getDocHeight = (doc) ->
    doc = doc || document
    body = doc.body
    html = doc.documentElement
    cath.max( body.scrollHeight, body.offsetHeight,
      html.clientHeight, html.scrollHeight, html.offsetHeight )

  setSource = ->
    docpath = $('[name=docpath]').val()
    format = $('[name=format]').val()
    url = '/data/project/document?' +
      $.param docpath: docpath, format: format

    $('#viewer')
      .attr('src', url)
      .height('25em')

  $(document).ready ->

    $('[name=format]').on('change', ->
      console.log('format change')
      setSource()
    )

    setSource()

