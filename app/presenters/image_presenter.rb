# frozen_string_literal: true

class ImagePresenter < LulalalaPresenter::Base
  def linked_display
    h.link_to(
      h.image_tag(h.image_url(model.image.thumb.url), width: model.thumb_width, height: model.thumb_height),
      h.image_url(model.image.url),
      class: 'img'
    ).html_safe
  end

  # Linked image in a container which clears floats,
  # so images will occupy entire row.
  def cleared_linked_display
    h.content_tag(:div, linked_display, class: 'images single clear').html_safe
  end
end
