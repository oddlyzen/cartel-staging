Controllers['my/companies'] = -> class MyCompanies
  new: (action) ->
    prepare_country_city_selection('select[data-selectize-country=company]')
    name_autocomplete()
    initialize_tag_list()
    tag_visibility()

  edit: (action) ->
    prepare_country_city_selection('select[data-selectize-country=company]')
    initialize_tag_list()
    tag_visibility()

  create: (action) -> @new(action)

  name_autocomplete = ->
    $('select[data-selectize-company=true]').selectize(
      create: (input) ->
        {
          value: input
          text: input
        }
      render: option_create: (data, escape) ->
        '<div class="create">This is a new company. Click to add <strong>' + escape(data.input) + '</strong>&hellip;</div>'
    )

  initialize_tag_list = ->
    $('select[data-selectize-organisation-type]').selectize
      delimiter: ','
      render: option_create: (data, escape) ->
        '<div class="create">This is a Organization Type. Pending approval from admin. Click to add <strong>' + escape(data.input) + '</strong>&hellip;</div>'
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

  tag_visibility = ->
    $('.check_boxes input[type="checkbox"]').last().click ->
      other = $(this)
      if other.is(':checked')
        show_tag()
      else
        hide_tag()

    if $('.check_boxes input[type="checkbox"]').last().is(':checked')
      show_tag()

  show_tag = ->
    $('.my_company_form_company_organization_type_ids .selectize-input').show()

  hide_tag = ->
    $('.my_company_form_company_organization_type_ids .selectize-input').hide()
