$.fn.inputs = (action) ->
  if action == 'enable'
    @prop('disabled', false)
  else if action == 'disable'
    @prop('disabled', true)
