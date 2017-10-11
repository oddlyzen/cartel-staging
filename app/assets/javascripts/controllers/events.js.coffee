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

    $('.opening-time-closed').on 'change', ->
      if ($(this).is(":checked"))
        $(this).parent().siblings(".start-end-times").addClass("hidden");
      else
        $(this).parent().siblings(".start-end-times").removeClass("hidden");

    window.onPhotoUpload = (file) ->
      filepicker.processImage(
        file.fpfile.url,
        {
          conversions: ['rotate', 'crop', 'filter'],
          cropRatio: 4/1
        },
        (Blob) ->
          $('.img-container-cover').css("background-image", "url(#{Blob.url})")
          $('#event_cover_image_url').val(Blob.url)
      );
  edit: (action) ->
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

    $('.opening-time-closed').on 'change', ->
      if ($(this).is(":checked"))
        $(this).parent().siblings(".start-end-times").addClass("hidden");
      else
        $(this).parent().siblings(".start-end-times").removeClass("hidden");

    window.onPhotoUpload = (file) ->
      filepicker.processImage(
        file.fpfile.url,
        {
          conversions: ['rotate', 'crop', 'filter'],
          cropRatio: 4/1
        },
        (Blob) ->
          $('.img-container-cover img').css("display", "none")
          $('.img-container-cover').css("background-image", "url(#{Blob.url})")
          $('#event_cover_image_url').val(Blob.url)
      );

