Controllers['registrations'] = -> class Registrations
  new: (action) ->
    $('#artist').on 'click', ->
      $('#artist-question').modal('show')

    $('#professional').on 'click', ->
      $('#professional-question').modal('show')

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
      if personalDetailsValid()
        $('.page-1').attr 'hidden', ''
        $('.page-artist').removeAttr 'hidden'
        $('.page-professional').find('input, select, button').prop 'disabled', true
        $('.page-artist').find('input, select, button').prop 'disabled', false
        $('.register').prop 'disabled', true
      else
        showPersonalDetailsValidations()

    $('#professional-question .yes').on 'click', ->
      $('.modal').modal 'hide'
      $('.professional').data('involvement', 'true')
      if personalDetailsValid()
        $('.page-1').attr 'hidden', ''
        $('.page-professional').removeAttr 'hidden'
        $('.page-artist').find('input, select, button').prop 'disabled', true
        $('.page-professional').find('input, select, button').prop 'disabled', false
        $('.register').prop 'disabled', true
      else
        showPersonalDetailsValidations()

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
    gender_male_field = $('#registration_form_user_attributes_gender_male')
    gender_female_field = $('#registration_form_user_attributes_gender_female')
    date_of_birth1_field = $('#registration_form_user_attributes_date_of_birth_1i')
    date_of_birth2_field = $('#registration_form_user_attributes_date_of_birth_2i')
    date_of_birth3_field = $('#registration_form_user_attributes_date_of_birth_3i')
    based_location_field = $('#registration_form_user_attributes_based_location')

    if first_name_field.val() && last_name_field.val() && email_field.val() && password_field.val() && password_confirmation_field.val() && (gender_male_field.prop("checked") || gender_female_field.prop("checked")) && date_of_birth1_field.val() && date_of_birth2_field.val() && date_of_birth3_field.val() && based_location_field.val() && password_field.val() == password_confirmation_field.val()
      return true
    else
      return false

  showPersonalDetailsValidations = ->
    first_name_field = $('#registration_form_user_attributes_first_name')
    last_name_field = $('#registration_form_user_attributes_last_name')
    email_field = $('#registration_form_user_attributes_email')
    password_field = $('#registration_form_user_attributes_password')
    password_confirmation_field = $('#registration_form_user_attributes_password_confirmation')
    gender_male_field = $('#registration_form_user_attributes_gender_male')
    gender_female_field = $('#registration_form_user_attributes_gender_female')
    date_of_birth1_field = $('#registration_form_user_attributes_date_of_birth_1i')
    date_of_birth2_field = $('#registration_form_user_attributes_date_of_birth_2i')
    date_of_birth3_field = $('#registration_form_user_attributes_date_of_birth_3i')
    based_location_field = $('#registration_form_user_attributes_based_location')

    if !first_name_field.val()
      first_name_field.addClass("error")
      $(".first-name-validation").remove()
      $(".registration_form_user_first_name").append('<span class="error-help first-name-validation"><i>Provide first name</i></span>')
    else
      first_name_field.removeClass("error")
      $(".first-name-validation").remove()

    if !last_name_field.val()
      last_name_field.addClass("error")
      $(".last-name-validation").remove()
      $(".registration_form_user_last_name").append('<span class="error-help last-name-validation"><i>Provide last name</i></span>')
    else
      last_name_field.removeClass("error")
      $(".last-name-validation").remove()

    if !email_field.val()
      email_field.addClass("error")
      $(".email-validation").remove()
      $(".registration_form_user_email").append('<span class="error-help email-validation"><i>Provide a valid email address</i></span>')
    else
      email_field.removeClass("error")
      $(".email-validation").remove()

    if !password_field.val()
      password_field.addClass("error")
      $(".password-validation").remove()
      $(".registration_form_user_password").append('<span class="error-help password-validation"><i>Provide password</i></span>')
    else
      password_field.removeClass("error")
      $(".password-validation").remove()

    if !password_confirmation_field.val() || password_confirmation_field.val() != password_field.val()
      password_confirmation_field.addClass("error")
      $(".password-confirmation-validation").remove()
      $(".registration_form_user_password_confirmation").append('<span class="error-help password-confirmation-validation"><i>Confirm matched password</i></span>')
    else
      password_confirmation_field.removeClass("error")
      $(".password-confirmation-validation").remove()

    if !gender_male_field.prop("checked") && !gender_female_field.prop("checked")
      $(".gender-validation").remove()
      $(".registration_form_user_gender").append('<div class="error-help gender-validation"><i>Provide gender</i></div>')
    else
      $(".gender-validation").remove()

    if !date_of_birth1_field.val() || !date_of_birth2_field.val() || !date_of_birth3_field.val()
      $(".dob-validation").remove()
      $(".registration_form_user_date_of_birth").append('<span class="error-help dob-validation"><i>Provide full date of birth</i></span>')
    else
      $(".dob-validation").remove()

    if !based_location_field.val()
      based_location_field.addClass("error")
      $(".location-validation").remove()
      $(".registration_form_user_based_location").append('<span class="error-help location-validation"><i>Provide location</i></span>')
    else
      based_location_field.removeClass("error")
      $(".location-validation").remove()

