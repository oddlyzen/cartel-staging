window.Controllers = {} # namespace for controller loaders
controllers = {} # holds the loaded controllers for re-use when working with Turbolinks
# helper to bind an event handler and optionally call it immediately
Controllers.bind = (call, $el, selector, evt, handler) ->
  if call
    for el in $el.find(selector)
      handler({ currentTarget: el })
  $el.on(evt, selector, handler)
  return
# run the controller-action for the current view
$(document).on 'ready', ->
  $body = $(document.body)
  window.$debug = $body.attr('data-debug')
  view = $body.attr('data-view')
  console.log('view:', view) if $debug
  [controller, action] = view.split('#')

  if (loader = Controllers[controller])
    c = (controllers[controller] ||= new (loader()))
    return if c.before_action && c.before_action(action) == false
    return if c[action]       && c[action](action)       == false
    return if c.after_action  && c.after_action(action)  == false
  return
