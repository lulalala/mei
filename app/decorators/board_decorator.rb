class BoardDecorator < ActiveDecorator::BaseDecorator
  def representative_image_url
    model.config.seo.image
  end

  def og_image_tag
    if image = representative_image_url
      h.tag(:meta, property:'og:image', content:h.image_url(image))
    end
  end
end
