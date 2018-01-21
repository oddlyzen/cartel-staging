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
      filepicker.processImage(
        file.fpfile.url,
        {
          conversions: ['rotate', 'crop', 'filter'],
          cropRatio: 1/1
        },
        (Blob) ->
          $('.img-container').css("background-image", "url(#{Blob.url})")
          $('.profile-image').attr('src', Blob.url)
          $('#my_profile_form_user_attributes_profile_image_url').val(Blob.url)
      );

    $.validator.addMethod "startDateBeforeEndDate", (value, element) ->
      start_month = $(element).closest('.nested-fields').find('[name*="[start_month]"]').val()
      start_year = $(element).closest('.nested-fields').find('[name*="[start_year]"]').val()
      end_month = $(element).closest('.nested-fields').find('[name*="[end_month]"]').val()
      end_year = $(element).closest('.nested-fields').find('[name*="[end_year]"]').val()
      start = new Date(start_year + '-' + start_month + '-01')
      end = new Date(end_year + '-' + end_month + '-01')

      if !start_month || !start_year || !end_month || !end_year
        return true

      if Date.parse(start) > Date.parse(end)
        return false;
      return true;
    , 'End date must be after start date.'

    # start of form validation
    # basic form validation
    artist_profile_form = $('#professional-profile-form-validate form, #artist-profile-form-validate form')
    artist_profile_form.validate()
    # custom 'till present' validation
    add_another_buttons = $('.adding-another')
    add_end_dates_validation = () ->
      setTimeout ( ->
        all_dates = $('.my_profile_form_user_educations_end_year select, .my_profile_form_user_educations_end_month select, .my_profile_form_user_residencies_end_month select, .my_profile_form_user_residencies_end_year select, .my_profile_form_user_experiences_end_month select, .my_profile_form_user_experiences_end_year select, .my_profile_form_user_educations_start_year select, .my_profile_form_user_educations_start_month select, .my_profile_form_user_residencies_start_month select, .my_profile_form_user_residencies_start_year select, .my_profile_form_user_experiences_start_month select, .my_profile_form_user_experiences_start_year select')

        end_dates = $('.my_profile_form_user_educations_end_year select, .my_profile_form_user_educations_end_month select, .my_profile_form_user_residencies_end_month select, .my_profile_form_user_residencies_end_year select, .my_profile_form_user_experiences_end_month select, .my_profile_form_user_experiences_end_year select')

        $.each end_dates, () ->
          $(this).rules('add', {
            required: {
              param: true,
              depends: ()->
                return !$(this).closest('.nested-fields').find('[name*="[current]"]').is(':checked');
            },
            startDateBeforeEndDate: true,
            messages: {
              required: 'This field is required unless "Present" is selected.'
            }
          })

        all_dates.on 'change', () -> end_dates.valid()

      ), 500

    add_another_buttons.on 'click', add_end_dates_validation

    add_end_dates_validation()

    # end of form validation

    # start of bibliography/publications hide/show
    source_type_selects = $('select[id*="publications_attributes"][name*="category"], select[id*="bibliographies_attributes"][name*="source_type"]')

    hide_show_fields = (el) ->
      el = $(el)
      type = el.val();
      fieldset = el.closest('fieldset')

      title = fieldset.find('[name*="title"]')
      author = fieldset.find('[name*="author"]')
      link = fieldset.find('[name*="link"]')
      participation = fieldset.find('[name*="participation"]')


      publication_title = fieldset.find('[name*="publication_title"]')
      publisher = fieldset.find('[name*="publisher"]')
      edition = fieldset.find('[name*="edition"]')
      editor = fieldset.find('[name*="editor"]')
      location = fieldset.find('[name*="location"]')
      issue = fieldset.find('[name*="issue"]')
      page_number = fieldset.find('[name*="page_number"]')
      volume = fieldset.find('[name*="volume"]')
      review_of = fieldset.find('[name*="review_of"]')

      day = fieldset.find('[name*="day"]')
      month = fieldset.find('[name*="month"]')
      year = fieldset.find('[name*="year"]')
      date_fields = [day, month, year]

      fields = {
        book: {
          show: [publisher, edition, editor, location, title, author, link, participation, page_number],
          hide: [publication_title, issue, volume, review_of]
        },
        catalogue: {
          show: [publisher, page_number, location, title, author, link, participation],
          hide: [publication_title, issue, edition, volume, review_of, editor]
        },
        article: {
          show: [publication_title, volume, issue, page_number, title, author, link, participation],
          hide: [publisher, edition, location, editor, review_of]
        },
        essay: {
          show: [publication_title, edition, editor, location, page_number, title, author, link, participation, publisher],
          hide: [volume, issue, review_of]
        },
        review: {
          show: [publication_title, review_of, volume, issue, editor, page_number, title, author, link, participation],
          hide: [publisher, edition, location]
        },
        paper: {
          show: [title, author, link, participation],
          hide: [publication_title, review_of, volume, issue, editor, page_number, publisher, edition, location]
        },
        all: {
          show: []
          hide: [publication_title, review_of, volume, issue, editor, page_number, publisher, edition, location, title, author, link, participation],
        }
      }

      if type == 'book' || type == 'catalogue'
        publisher.attr('placeholder', 'Publisher*')
      else
        publisher.attr('placeholder', 'Publisher')

      if type == 'article' || type == 'essay'
        publication_title.attr('placeholder', 'Publication Title*')
      else
        publication_title.attr('placeholder', 'Publication Title')

      if type != 'catalogue'
        author.attr('placeholder', 'Author*')
      else
        author.attr('placeholder', 'Author')

      if !type
        type = 'all'

      $.each date_fields, (i, field) ->
        $(field).hide()

      switch type
        when 'book', 'essay', 'paper'
          year.show()
        when 'article', 'review', 'catalogue'
          day.show()
          month.show()
          year.show()

      $.each fields[type].show, (i, field) ->
        $(field).show()

      $.each fields[type].hide, (i, field) ->
        $(field).hide()

    $.each source_type_selects, (i, select) ->
      hide_show_fields(select)

    $(document).on 'change', 'select[id*="publications_attributes"][name*="category"], select[id*="bibliographies_attributes"][name*="source_type"]', (e) -> hide_show_fields(e.target)
    # end of bibliography/publications hide/show

    $(document).on 'change', '.institution-name', (e) ->
      if $(this).val() == "Other"
        $(this).parent().siblings(".my_profile_form_user_educations_other_institution").children().removeClass("hidden")
      else
        $(this).parent().siblings(".my_profile_form_user_educations_other_institution").children().addClass("hidden")


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
