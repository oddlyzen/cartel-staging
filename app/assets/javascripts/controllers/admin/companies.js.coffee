Controllers['admin/companies'] = -> class AdminCompanies
  edit: (action) ->
    window.onCompanyPhotoUpload = (file) ->
      $('.company-image').attr('src', file.fpfile.url)
      $('.img-container').css("background-image", "url(#{file.fpfile.url})")
