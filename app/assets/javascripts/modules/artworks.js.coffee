$(document).ready ->
  $('#artwork_description').simplyCountable
    counter: '#counter'
    countType: 'characters'
    maxCount: 1000
    strictMax: true
    countDirection: 'down'
    thousandSeparator: ''
    onMaxCount: (count, countable, counter) ->

  window.documentBulkUpload = (file) ->
    filenames = "";
    $(file.fpfiles).each (index, uploadedFile) ->
      filenames += (uploadedFile.filename + ",")
    $("#document_bulk_upload_form_titles").val(filenames)
