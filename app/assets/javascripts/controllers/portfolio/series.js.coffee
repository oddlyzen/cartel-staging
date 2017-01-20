Controllers['portfolio/series'] = -> class PortfolioSeries
  edit: (action) ->
    initialize_tooltip()
    initialize_publish_helper()
    initialize_multiselect_helper()
    initialize_show_exhibition_helper()
    initialize_modal_helper()
    initialize_bulk_edit_helper()
    initialize_set_cover_helper()
    selectize_tag_list()
    selectize_company_find_or_create()
    prepare_country_city_selection('select[data-selectize-country=exhibition-new]')
    prepare_country_city_selection('select[data-selectize-country=artwork-bulk-edit]')

  update: (action) -> @edit(action)

  rearrange: (action) ->
    if gon.artworks
      artworks = JSON.parse(gon.artworks)

      $('#artwork_arrangement_form_artworks_order').selectize
        plugins: [
          'drag_drop'
          'no-delete'
        ]
        persist: false
        create: false
        delimiter: ','
        render: item: (item) ->
          index = item.$order - 1
          image = '<img src="' + artworks[index].image_url + '/convert?align=faces&fit=crop&h=160&w=260"/>'
          title = '<b>' + (artworks[index].title or 'No Title') + '</b>'
          '<div class="card">' + image + title + '</div>'

  initialize_tooltip = ->
    $('[data-tooltip="tooltip"]').tooltip()

  initialize_publish_helper = ->
    $('#publish-series').click (e) ->
      e.preventDefault()
      e.stopPropagation()
      url = $(this).attr('href')
      form =  $('.new_series_update_form')
      form.attr('action',url)
      form.submit()

  initialize_multiselect_helper = ->
    $('#js-select-all').click ->
      $('.card input[type="checkbox"]').each ->
        @checked = true
        return

    $('#js-select-none').click ->
      $('.card input[type="checkbox"]').each ->
        @checked = false
        return

  initialize_bulk_edit_helper = ->
    $('form#new_artwork').submit ->
      ids = []
      $('.card :checkbox:checked').each ->
        ids.push $(this).val()

      if ids.length > 0
        $('#artwork_ids').attr('value', ids)
      return

  initialize_set_cover_helper = ->
    $('#js-set-cover').click ->
      id = $('.card :checkbox:checked')[0].value
      $(this).attr 'href', (_i, url) ->
        url + "?artwork_id=#{id}"
      return

  initialize_show_exhibition_helper = ->
    $('.js-new-exhibition input').inputs('disable')

    $('#js-show-exhibition').click ->
      $('.js-existing-exhibition select').inputs('disable')
      $('.js-new-exhibition').show()

      $('.js-new-exhibition input').inputs('enable')
      $('.js-existing-exhibition').hide()

  initialize_modal_helper = ->
    $('#js-modal-alert').on 'show.bs.modal', (e) ->
      link = $(e.relatedTarget)
      url = link.data('url')

      ids = []
      $('.card :checkbox:checked').each ->
        ids.push $(this).val()

      modal = $(this)

      if ids.length > 0
        modal.find('.btn').attr('href', url + "?ids=#{ids.join()}")
      else
        modal.find('.btn').attr('href', url)


  selectize_tag_list = ->
    $('select[data-selectize-tag=true]').selectize
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

  selectize_company_find_or_create = ->
    $('select[data-selectize-company=true]').selectize
      render: option_create: (data, escape) ->
        '<div class="create">This is a new company. Click to add <strong>' + escape(data.input) + '</strong>&hellip;</div>'
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
