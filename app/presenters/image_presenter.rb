class ImagePresenter < LulalalaPresenter::Base
  def linked_display
    h.link_to(
      h.image_tag(h.image_url(model.image.thumb.url)),
      h.image_url(model.image.url),
      class:'img'
    ).html_safe
  end
end
