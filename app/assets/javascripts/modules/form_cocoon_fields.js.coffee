$ ->
  $(document).on 'submit', 'form', (e)->
    return if $(this).attr('data-remote')
    nested_fieldsets = $(this).find('fieldset.nested-fields')
    for fieldset in nested_fieldsets
      $fieldset = $(fieldset)
      $fields = $fieldset.find('input, textarea, select')
      if is_blank_fields($fields)
        $fieldset.inputs('disable')

is_blank_fields = ($fields) ->
  for field in $fields
    $field = $(field)
    switch $field.attr('type')
      when 'checkbox', 'radio', 'hidden'
        continue
    return false if $field.val() != ''
  true
