Controllers['portfolio/artworks'] = -> class PortfolioArtworks
  index: (action) ->
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

    prepare_country_city_selection('select[data-selectize-country]')
    $('select[data-selectize-collaborator=true').selectize()

  upload: (action) ->
    changeGroupButtonStatus =->
      if ($('.cards.cards--artworks .card input:checked').length <= 0)
        $('.new_bulk_group_form .no-artwork-selected').removeClass('hidden')
        $('.new_bulk_group_form .artwork-selected').addClass('hidden')
      else
        $('.new_bulk_group_form .no-artwork-selected').addClass('hidden')
        $('.new_bulk_group_form .artwork-selected').removeClass('hidden')
      return

    $('#js-select-series-all').click ->
      $('.cards--artworks .card input[type="checkbox"]').each ->
        @checked = true
        changeGroupButtonStatus()
        return

    $('.artwork-series').click ->
      event.preventDefault()
      series_id = $(this).data('series')
      $("#bulk_group_form_series").val(series_id)
      $("#new_bulk_group_form").submit()

    $('#js-select-series-none').click ->
      $('.cards--artworks .card input[type="checkbox"]').each ->
        @checked = false
        changeGroupButtonStatus()
        return

    $('.cards.cards--artworks .card input[type="checkbox"]').on 'change', ->
      changeGroupButtonStatus()

    changeGroupButtonStatus()
