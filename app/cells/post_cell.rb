class PostCell < Cell::Rails
  helper ApplicationHelper

  def show(post)
    @post = post
    render
  end

  def form(topic)
    @post_form = PostForm.new.from_topic(topic)
    render
  end

  def image_upload_control(post_field)
    @post_field = post_field
    render
  end
end
