Controllers['my/settings'] = -> class MySettings
  show: (action) ->
    $(document).on 'focus', '#reason_deactivating_input', ->
      $('#other_radio').prop("checked", true)

    $(document).on 'keyup', '#reason_deactivating_input', ->
      $('#other_radio').val($(this).val())

    $(document).on 'click', 'label#other_label', ->
      $('#reason_deactivating_input').focus()
