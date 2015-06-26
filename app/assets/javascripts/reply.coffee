#= require post_handle
#= require image_upload

replyContainer = null
currentTopicId = null

$ ->
  $('.topic').on 'click', '.actions .reply', (e)->
    e.preventDefault()

    topicId = $(e.delegateTarget).data('id')
    postId = $(e.target).parents('.post').data('id')

    replyContainer = $('#reply-container')

    if replyContainer.length
      textArea = replyContainer.find('textarea')
      if currentTopicId == topicId
        if ! firstPostFromTopic(topicId, postId)
          insertPostId(textArea, postId)
      else
        if textArea.value == '' || confirm('You are about to switch thread which would cause currently unsaved reply to be cleared. Continue?')
          # clear current form
          replyContainer.remove()
          replyContainer = [] # empty

    # load form if none exists
    if ! replyContainer.length
      loadReplyForm(prepareUrl(e.target.getAttribute('href')), topicId, postId)

insertPostId = (textarea, postId)->
  t = textarea.val()
  if t.length > 0
    t = t + "\n"
  t = t + "> #{postId}\n"
  textarea.val(t).focus()
  textarea[0].scrollTop = textarea[0].scrollHeight

loadReplyForm = (url, topicId, postId)->
  $.get(url, topic_id:topicId).done (html)->
    $('body>footer').before("<div id='reply-container'>" + html + "</div>")
    if ! firstPostFromTopic(topicId, postId)
      insertPostId($('#reply-container').find('textarea'), postId)
    currentTopicId = topicId

    new ImageUpload($('#reply-container .file-section'))

prepareUrl = (path)->
  path.replace(/topics.*/, 'posts/new')

firstPostFromTopic = (topicId, postId)->
  topicEl = $(".topic[data-id=#{topicId}]")
  firstPost = topicEl.find(".post:first-of-type")
  firstPost.data('id') == postId

PostHandle.register ($postEl)->
  return if $postEl.index() != 1
  url = $postEl.find('.actions .reply').attr('href')
  $postEl.find('.actions').prepend(" <a class='permalink' href='#{url}'>Thread Permalink</a>")
