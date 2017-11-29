class Topic::Reply < ActiveInteraction::Base
  object :topic, class:Topic
  string :author, default: nil
  string :content, default: nil
  string :options_raw, default: nil
  array :images, default: nil do
    object class: Image
  end

  def execute
    post = topic.posts.build
    post.assign_attributes(
      author: author,
      content: content,
      options_raw: options_raw,
    )
    post.images.concat(images) if images

    if !post.save
      errors.merge!(post.errors)
    end

    post
  end
end