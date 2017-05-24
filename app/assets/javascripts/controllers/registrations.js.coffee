Controllers['registrations'] = -> class Registrations
  new: (action) ->
    $('#artist').on 'click', ->
      if personalDetailsValid()
        if $('.artist').data('involvement') == false
          $('#artist-question').modal('show')
        $('.page-1').attr 'hidden', ''
        $('.page-artist').removeAttr 'hidden'
        $('.page-professional').find('input, select, button').prop 'disabled', true
        $('.page-artist').find('input, select, button').prop 'disabled', false
        $('.register').prop 'disabled', true
      else
        $('#personal-details-validation').modal('show')

    $('#professional').on 'click', ->
      if personalDetailsValid()
        if $('.professional').data('involvement') == false
          $('#professional-question').modal('show')
        $('.page-1').attr 'hidden', ''
        $('.page-professional').removeAttr 'hidden'
        $('.page-artist').find('input, select, button').prop 'disabled', true
        $('.page-professional').find('input, select, button').prop 'disabled', false
        $('.register').prop 'disabled', true
      else
        $('#personal-details-validation').modal('show')

    $('#back-artist, #back-pro').on 'click', ->
      $('.page-artist, .page-professional').attr 'hidden', ''
      $('.page-1').removeAttr 'hidden'
      $('#professional_acknowledgement').prop('checked', false)
      $('#artist_acknowledgement').prop('checked', false)

      if $('#professional_acknowledgement').is(':checked') or $('#artist_acknowledgement').is(':checked')
        $('.register').prop 'disabled', false
      else
        $('.register').prop 'disabled', true

    $('#professional_acknowledgement, #artist_acknowledgement').on 'click', ->
      if $('#professional_acknowledgement').is(':checked') or $('#artist_acknowledgement').is(':checked')
        $('.register').prop 'disabled', false
      else
        $('.register').prop 'disabled', true

    $('.artist_current_status select, #registration_form_other_media_array, #registration_form_other_subjects_array, #registration_form_other_specialisations_array').selectize(
      create: (input) ->
        {
          value: input
          text: input
        }
      render: option_create: (data, escape) ->
        '<div class="create">This is a new tag. Pending approval from admin. Click to add <strong>' + escape(data.input) + '</strong>&hellip;</div>'
    )

    $('.professional_current_status select').selectize(
      create: true
      render: option_create: (data, escape) ->
        '<div class="create">This is a new tag. Pending approval from admin. Click to add <strong>' + escape(data.input) + '</strong>&hellip;</div>'
    )

    prepare_country_city_selection('select[data-selectize-country=based_country]')
    $('#registration_form_user_attributes_nationality_country').selectize()

    $(".add_fields").click()
    selectize_company('select[data-selectize-company=true]')
    prepare_country_city_selection('select[data-selectize-country=registration-exhibition-new]')
    prepare_country_city_selection('select[data-selectize-country=registration-experience-new]')

    $('#exhibitions').on 'cocoon:after-insert', (e, experience) ->
      company_field = experience.find('select[data-selectize-company=true]')
      selectize_company(company_field)

      filepicker_init()

      country_field = experience.find('select[data-selectize-country=registration-exhibition-new]')
      prepare_country_city_selection(country_field, experience)


    $('#experiences').on 'cocoon:after-insert', (e, experience) ->
      company_field = experience.find('select[data-selectize-company=true]')
      selectize_company(company_field)

      country_field = experience.find('select[data-selectize-country=registration-experience-new]')
      prepare_country_city_selection(country_field, experience)

    $('.page-artist #registration_form_user_attributes_current_status').change toggle_artist_current_status
    $('.page-professional #registration_form_user_attributes_current_status').change toggle_professional_current_status

    $('.registration_form_profile_medium_ids').on 'click', toggle_media_tags

    $('#artist-question .yes').on 'click', ->
      $('.modal').modal 'hide'
      $('.artist').data('involvement', 'true')

    $('#professional-question .yes').on 'click', ->
      $('.modal').modal 'hide'
      $('.professional').data('involvement', 'true')

    $('.artist-no').on 'click', ->
      $('#artist-question').modal 'hide'

    $('.professional-no').on 'click', ->
      $('#professional-question').modal 'hide'

    prepare_current_status()
    toggle_artist_current_status()
    toggle_professional_current_status()
    toggle_media_tags()
    return

  prepare_current_status = ->
    $('.page-artist, .page-professional').find('#registration_form_user_attributes_current_status').each (idx, elem) ->
      if $(elem).children('option[selected], option[value=""]').length == 0
        $(elem).prepend('<option selected>Please Select</option>')
      return
    return

  toggle_artist_current_status = ->
    groupedItems =
      'Represented by': $('.artist_current_status .select')
      'Other': $('.artist_current_status .string')

    for status, items of groupedItems
      items.addClass 'hidden'

    value = $('.page-artist #registration_form_user_attributes_current_status').val()
    groupedItems[value].removeClass 'hidden' if groupedItems[value]
    return

  toggle_professional_current_status = ->
    groupedItems =
      'Works at': $('.professional_current_status .select')
      'Other': $('.professional_current_status .string')

    for status, items of groupedItems
      items.addClass 'hidden'

    value = $('.page-professional #registration_form_user_attributes_current_status').val()
    groupedItems[value].removeClass 'hidden' if groupedItems[value]
    return

  toggle_media_tags = ->
    other_media_isChecked = $('.check_boxes.registration_form_profile_medium_ids input[type="checkbox"]').last().is(':checked')
    $('.artist_media .selectized, .artist_media .selectize-control').toggleClass('hidden', !other_media_isChecked)
    $('.artist_media').find('.selectize-dropdown').toggleClass('hidden', !other_media_isChecked)
    return

  selectize_company = (company_field)->
    $(company_field).selectize
      create: true
      render: option_create: (data, escape) ->
        '<div class="create">This is a new Company. Pending approval from admin. Click to add <strong>' + escape(data.input) + '</strong>&hellip;</div>'

  personalDetailsValid = ->
    first_name_field = $('#registration_form_user_attributes_first_name')
    last_name_field = $('#registration_form_user_attributes_last_name')
    email_field = $('#registration_form_user_attributes_email')
    password_field = $('#registration_form_user_attributes_password')
    password_confirmation_field = $('#registration_form_user_attributes_password_confirmation')

    if first_name_field.val() && last_name_field.val() && email_field.val() && password_field.val() && password_confirmation_field.val() && password_field.val() == password_confirmation_field.val()
      return true
    else
      return false
