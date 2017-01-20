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
      if ( $('.cards.all-series .card input:checked').length <= 0 || $('.cards.cards--artworks .card input:checked').length <= 0)
        $('.new_bulk_group_form input.group-submit').prop('disabled', 'disabled')
      else
        $('.new_bulk_group_form input.group-submit').removeProp('disabled')
      return

    $('.cards.all-series .card input[type="checkbox"]').on 'change', ->
      cbox = $(this)
      cards = cbox.parents('.cards')
      cards.find('input[type=checkbox]').prop('checked', false)

      if cbox.is(':checked')
        cbox.prop('checked', false)
      else
        cbox.prop('checked', true)
      changeGroupButtonStatus()
      return

    $('#js-select-series-all').click ->
      $('.cards--artworks .card input[type="checkbox"]').each ->
        @checked = true
        changeGroupButtonStatus()
        return

    $('#js-select-series-none').click ->
      $('.cards--artworks .card input[type="checkbox"]').each ->
        @checked = false
        changeGroupButtonStatus()
        return

    $('.cards.cards--artworks .card input[type="checkbox"]').on 'change', ->
      changeGroupButtonStatus()
