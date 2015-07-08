$(document).on 'click', '[data-behavior=view-omitted]', (e)->
  e.preventDefault()

  $target = $(e.target)

  url = "#{$target.attr('href')}/omitted"
  request = $.ajax
    url:url,
    method:'GET'
    dataType:'html'

  request.done (msg)->
    $target.parent().replaceWith(msg)
    PostHandle.apply()
