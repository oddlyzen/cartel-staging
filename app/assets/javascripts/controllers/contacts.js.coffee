Controllers['contacts'] = -> class Contacts
  interest: (action) ->
    window.aboutPageAttachmentUpload = (file) ->
      $('.about-us-attachment p').text('File Name: ' + file.fpfile.filename)

    $('#interest_form_interest').on 'change', ->
      if $(this).val() in ["Artist", "Art Professional"]
        $('.about-us-attachment').removeClass("hidden")
      else
        $('.about-us-attachment').addClass("hidden")

