class BoardPresenter < LulalalaPresenter::Base
  def representative_image_url
    model.config.dig(:seo, :image)
  end

  def og_image_tag
    if image = representative_image_url
      h.tag(:meta, property:'og:image', content:h.image_url(image))
    end
  end
end
