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

