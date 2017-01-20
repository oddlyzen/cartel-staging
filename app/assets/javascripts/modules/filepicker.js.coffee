window.filepicker_init = ->
  $('input[type=filepicker], input[type=filepicker-dragdrop]').each ->
    if $(this).is(':visible')
      filepicker.constructWidget this
