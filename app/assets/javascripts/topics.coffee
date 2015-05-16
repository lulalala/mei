# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $document = $(document)

  $document.on 'ajax:before', 'form#new_post', ->
    $('form img.loading').show()
  $document.on 'ajax:error', 'form#new_post', (event, data, status, xhr)->
    $('form img.loading').hide()
  $document.on 'ajax:success', 'form#new_post', (event, data, status, xhr)->
    if data['success']
      location.reload()
    else
      $('form img.loading').hide()
