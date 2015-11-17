class TopicPresenter < LulalalaPresenter::Base
  def title
    if model.title.present?
      h.truncate(model.title, length: 50)
    elsif model.posts.first.content.present?
      h.truncate(model.posts.first.content, length: 50)
    else
      "##{model.id}"
    end
  end

  def representative_image_url
    post = model.posts.first
    if image = post.images.first
      image.image.url
    else
      model.board.decorator.representative_image_url
    end
  end

  def og_image_tag
    if image = representative_image_url
      h.tag(:meta, property:'og:image', content:h.image_url(image))
    end
  end
end
