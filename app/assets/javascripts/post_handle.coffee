# A class that correspond to each post element in the document.
# Filter can be registered, which will be run against each post element.
class PostHandle
  # @container: post element
  constructor: (@container)->
    $container = $(@container)
    for filter in @constructor.filters
      filter($container)

  @filters: []

  # filter: Function, accepts an argument which is the post container wrapped in jQuery object
  @register: (filter) ->
    @filters.push filter

  # search through document for posts and initialize with a handle
  @apply: ->
    $('article.post').each (index, postEl)->
      $postEl = $(postEl)
      if ! $postEl.data('handle')
        $postEl.data('handle', new PostHandle(postEl))

window.PostHandle = PostHandle

$ ->
  PostHandle.apply()
