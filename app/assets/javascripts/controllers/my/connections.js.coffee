Controllers['my/connections'] = -> class MyConnections
  index: (action) ->
    $('#disconnect').on 'show.bs.modal', (e) ->
      modal = $(e.relatedTarget)
      user_id = modal.data('userid')
      user_name = modal.data('friendname')
      link = modal.data('disconnectlink')
      $('#disconnect_btn').attr('href', link)
      text = 'Are you sure you want to remove ' + user_name +  ' from your network?'
      $('.modal-text p').replaceWith(text)
