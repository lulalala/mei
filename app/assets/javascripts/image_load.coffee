$(document).on 'click', 'article.post a.img', (e) ->
  e.preventDefault()

  a = $(this)
  fullImageUrl = this.href

  a.parents('article.post').addClass('full')
  $("<img>", {src:fullImageUrl, class:'full'}).insertAfter(a)
  a.hide()

$(document).on 'click', 'article.post img.full', (e) ->
  e.preventDefault()

  img = $(this)
  a = img.prev()

  img.remove()
  a.show()
