Controllers['my/profiles'] = -> class MyProfiles
  edit: (action) ->

    window.exhibitionUpload = (file) ->
      $('.exhibition-upload p').text 'File Name: ' + file.fpfile.filename
      $('.exhibition-pdf-filename').val(file.fpfile.filename)

    window.bibliographyUpload = (file) ->
      $('.bibliography-upload p').text 'File Name: ' + file.fpfile.filename
      $('.bibliography-pdf-filename').val(file.fpfile.filename)

    window.publicationsUpload = (file) ->
      $('.publications-upload p').text 'File Name: ' + file.fpfile.filename
      $('.publication-pdf-filename').val(file.fpfile.filename)

    window.onPhotoUpload = (file) ->
      $('.img-container').css("background-image", "url(#{file.fpfile.url})")
      $('.profile-image').attr('src', file.fpfile.url)



    $('form.simple_form.new_my_profile_form').on 'keypress', (e) ->
      if e.keyCode == 13
        e.preventDefault()
        return false

    toggleChevron = (e) ->
      $(e.target).prev('.panel-heading').find('i.indicator').toggleClass 'fa-chevron-up fa-chevron-down'
      return

    $('#accordion').on 'hidden.bs.collapse', toggleChevron
    $('#accordion').on 'shown.bs.collapse', toggleChevron

    $(document).on 'focus', '#current_status_input', ->
      $('#other_radio').prop("checked", true)

    $(document).on 'keyup', '#current_status_input', ->
      $('#other_radio').val($(this).val())

    $('textarea').focusin ->
      $('.box-border').css 'border', 'none solid solid solid'
      $('.box-border').css 'border-color', 'black'
      return

    prepare_country_city_selection('select[data-selectize-country=based_in]')

    $('select[data-selectize="true"').selectize()

    selectize_company('select[data-selectize-company=true]')

    selectize_language_field($("select[data-klass='Language']"))
    $('#language-proficiencies').on 'cocoon:after-insert', (e, language_proficiency_fields) ->

      language_field = language_proficiency_fields.find('.my_profile_form_user_profile_language_proficiencies_language select')
      selectize_language_field(language_field)

    prepare_country_city_selection('select[data-selectize-country]')

    $('#partial-award').on 'cocoon:after-insert', (e, award) ->

      country_field = award.find('select[data-selectize-country]')
      prepare_country_city_selection(country_field, award)

    $('#partial-residency').on 'cocoon:after-insert', (e, residency) ->
      residency.find('select[data-selectize="true"]').selectize()

      country_field = residency.find('select[data-selectize-country]')
      prepare_country_city_selection(country_field, residency)

    $('#partial-experience').on 'cocoon:after-insert', (e, experience) ->
      selectize_company('select[data-selectize-company=true]')

      country_field = experience.find('select[data-selectize-country]')
      prepare_country_city_selection(country_field, experience)

    $('#partial-exhibition').on 'cocoon:after-insert', (e, exhibition) ->
      filepicker_init()
      exhibition.find('select[data-selectize="true"]').selectize()

      country_field = exhibition.find('select[data-selectize-country]')
      prepare_country_city_selection(country_field, exhibition)

    $('#partial-publication').on 'cocoon:after-insert', (e, publication) ->
      filepicker_init()

      country_field = publication.find('select[data-selectize-country]')
      prepare_country_city_selection(country_field, publication)

    $('#partial-bibliography').on 'cocoon:after-insert', (e, bibliography) ->
      filepicker_init()

    $('select[data-klass="Medium"], select[data-klass="Subject"], select[data-klass="Skill"], select[data-klass="Specialisation"], select[data-klass="Service"]').selectize
      plugins: ['remove_button']
      delimiter: ','
      render: option_create: (data, escape) ->
        '<div class="create">This is a new tag. Pending approval from admin. Click to add <strong>' + escape(data.input) + '</strong>&hellip;</div>'
      create: (input, callback) ->
        klass = this.$input.data('klass')
        url = this.$input.data('url')
        $.ajax
          url: url
          type: 'POST'
          data:
            name: input
            klass: klass
          success: (tag) ->
            callback
              value: tag.id
              text: tag.name
        return

    status = $('#my_profile_form_user_attributes_current_status')
    companies = $('.my_profile_form_user_representative_ids')
    new_status = $('#my_profile_form_user_attributes_other_status')

    companies.hide()
    new_status.hide()

    setCurrentStatus = ->
      switch status.val()
        when 'Represented by', 'Works at'
          companies.show()
          new_status.hide()
        when 'Other'
          companies.hide()
          new_status.show()
        else
          companies.hide()
          new_status.hide()

    status.change ->
      setCurrentStatus()

    setCurrentStatus()

selectize_language_field = (language_field) ->
  $(language_field).selectize(
    render: option_create: (data, escape) ->
      '<div class="create">This is a new tag. Pending approval from admin. Click to add <strong>' + escape(data.input) + '</strong>&hellip;</div>'
    create: (input, callback) ->
      klass = this.$input.data('klass')
      url = this.$input.data('url')
      $.ajax
        url: url
        type: 'POST'
        data:
          name: input
          klass: klass
        success: (tag) ->
          callback
            value: tag.id
            text: tag.name
      return
  )

selectize_company = (company_field)->
  $(company_field).selectize(
    render: option_create: (data, escape) ->
      '<div class="create">This is a new Company. Pending approval from admin. Click to add <strong>' + escape(data.input) + '</strong>&hellip;</div>'
    create: (input, callback) ->
      klass = this.$input.data('klass')
      url = this.$input.data('url')
      $.ajax
        url: url
        type: 'POST'
        data:
          name: input
          klass: klass
        success: (company) ->
          callback
            value: company.id
            text: company.name
      return
  )
