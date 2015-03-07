function getDocHeight(doc) {
    doc = doc || document;
    // stackoverflow.com/questions/1145850/
    var body = doc.body, html = doc.documentElement;
    var height = Math.max( body.scrollHeight, body.offsetHeight, 
        html.clientHeight, html.scrollHeight, html.offsetHeight );
    return height;
}

function setSource() {
  var docpath = $('[name=docpath]').val()
    format = $('[name=format]').val()
    url = '/data/project/document?' + $.param({
      docpath: docpath,
      format: format
    })
  ;
  $('#viewer')
    .attr('src', url)
    .height('25em')/*
    .ready(function() {
      console.log(url, 'loaded' );
      var viewer = $('#viewer'), 
        doc = viewer.contentDocument ? viewer.contentDocument
          : viewer.contentWindow.document;

      console.log( getDocHeight( doc ));
    })*/
  ;
}

$(document).ready(function() {

  $('[name=format]').on('change', function() {
    console.log('format change');
    setSource();
  });

  setSource();

/*
   $.ajax( url, {
   success: function(data) {
   },
   error: function() {
   }
   }); */

});

