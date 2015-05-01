# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('form#new_post').on 'ajax:before', ->
    $('form img.loading').show()
  $('form#new_post').on 'ajax:error', (event, data, status, xhr)->
    $('form img.loading').hide()
  $('form#new_post').on 'ajax:success', (event, data, status, xhr)->
    if data['success']
      location.reload()
    else
      $('form img.loading').hide()
