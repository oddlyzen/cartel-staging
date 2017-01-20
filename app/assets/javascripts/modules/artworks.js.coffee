$(document).ready ->
  $('#artwork_description').simplyCountable
    counter: '#counter'
    countType: 'characters'
    maxCount: 1000
    strictMax: true
    countDirection: 'down'
    thousandSeparator: ''
    onMaxCount: (count, countable, counter) ->

