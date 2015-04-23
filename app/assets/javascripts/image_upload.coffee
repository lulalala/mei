# Image upload control

$(document).on 'ready', (e) ->
  updateView()

$(document).on 'click', '.field.image a.switch', (e) ->
  e.preventDefault()

  # toggle disable
  $('.field.image input.upload').prop 'disabled', (i,v)->
    !v

  updateView()

updateView = ->
  # visibility
  $('.field.image ').each (index, field)->
    field = $(field)
    if field.find('input.upload').prop('disabled')
      field.hide()
    else
      field.show()
