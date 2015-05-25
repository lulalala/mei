# Image upload control

$(document).on 'ready', (e) ->
  updateView()

$(document).on 'click', '.file-section .actions a.switch', (e) ->
  e.preventDefault()

  # toggle disable
  $('.field input.upload').prop 'disabled', (i,v)->
    !v

  updateView()

updateView = ->
  # visibility
  $('.field input').each (index, input)->
    input = $(input)
    if input.prop('disabled')
      input.addClass('hide')
    else
      input.removeClass('hide')

$ ->
  $(document).on 'click', '.file-section .actions .add', (e)->
    e.preventDefault()

    container = $(e.target).parents('.file-section')
    if !container.data("nestedAttributes")
      container.nestedAttributes(
        bindAddTo: $(e.target)
        collectionName: 'images'
        collectIdAttributes: false
        $clone: container.children('.field')
      ).nestedAttributes("add")
