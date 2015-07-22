#= require post_handle
#= require image_upload

replyContainer = null
currentTopicId = null

$ ->
  $('.topic').on 'click', '.actions .reply', (e)->
    e.preventDefault()

    topicId = $(e.delegateTarget).data('id')
    pos = $(e.target).parents('.post').data('pos')

    replyContainer = $('#reply-container')

    if replyContainer.length
      textArea = replyContainer.find('textarea')
      if currentTopicId == topicId
        if pos == 1
          textArea.focus()
        else
          insertRef(textArea, pos)
      else if textArea.val() == '' || confirm('You are about to switch thread which would cause currently unsaved reply to be cleared. Continue?')
        # clear current form
        replyContainer.remove()
        replyContainer = [] # empty

    # load form if none exists
    if ! replyContainer.length
      loadReplyForm(prepareUrl(e.target.getAttribute('href')), topicId, pos)

# quote reference to post in textarea
insertRef = (textarea, ref)->
  t = textarea.val()
  if t.length > 0
    t = t + "\n"
  t = t + "> #{ref}\n"
  textarea.val(t).focus()
  textarea[0].scrollTop = textarea[0].scrollHeight

loadReplyForm = (url, topicId, pos)->
  $.get(url, topic_id:topicId).done (html)->
    $('body>footer').before("<div id='reply-container'>" + html + "</div>")
    if pos != 1
      insertRef($('#reply-container').find('textarea'), pos)
    currentTopicId = topicId

    new ImageUpload($('#reply-container .file-section'))

prepareUrl = (path)->
  path.replace(/topics.*/, 'posts/new')

PostHandle.register ($postEl)->
  return if $postEl.index() != 1
  url = $postEl.find('.actions .reply').attr('href')
  $postEl.find('.actions').prepend(" <a class='permalink' href='#{url}'>Thread Permalink</a>")
