$ ->
  $(document).on 'click', 'a.img', (e) ->
    e.preventDefault()
    a = $(e.target)
    a.parents('article.post').addClass('full')
    a.parent().replaceWith($("<img>", {src:this.href, class:'full'}))
