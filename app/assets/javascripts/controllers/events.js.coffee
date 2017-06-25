Controllers['events'] = -> class Events
  new: (action) ->
    $('#event_event_type').on 'change', ->
      if ($(this).val() == "Exhibition")
        $(".type-other").addClass("hidden")
        $(".type-exhibition").removeClass("hidden")
      else if ($(this).val() == "Other")
        $(".type-other").removeClass("hidden")
        $(".type-exhibition").addClass("hidden")
      else
        $(".type-other").addClass("hidden")
        $(".type-exhibition").addClass("hidden")

