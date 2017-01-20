$ ->
  window.prepare_country_city_selection = (country_selector, container) ->
    countries = $(country_selector)
    for country in countries
      $select_country = $(country).selectize(onChange: (value) ->
        city_field = get_selectize_city_field_from(this.$input, container)
        select_city = city_field[0].selectize

        if !value.length
          return
        select_city.clearOptions()
        select_city.load (callback) ->
          xhr and xhr.abort()
          xhr = $.ajax(
            url: '/locations/' + value
            success: (results) ->
              items = results.map((x) -> { item: x })
              callback items
              return
            error: ->
              callback()
              return
          )
          return
        return
      )

      $select_city = get_selectize_city_field_from(country, container).selectize(
        labelField: 'item'
        valueField: 'item'
        searchField: 'item')

get_selectize_city_field_from = (country_field, container) ->
  partial_id = $(country_field).data('selectize-country')
  if container
    return $(container).find("select[data-selectize-state=#{partial_id}]")
  else
    return $("select[data-selectize-state=#{partial_id}]")
