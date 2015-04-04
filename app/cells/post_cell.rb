class PostCell < Cell::Rails
  def show(post)
    @post = post
    render
  end

  def form(post)
    @post = post
    if @post.images.empty?
      @post.images.build
    end
    render
  end

  def image_upload_control(post_field)
    @post_field = post_field
    render
  end
end
