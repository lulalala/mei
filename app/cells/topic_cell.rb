class TopicCell < Cell::Rails
  include ActionView::Helpers::FormHelper

  def show(topic)
    @topic = topic
    render
  end

  def form(topic)
    @topic = topic
    if @topic.new_record?
      @post = @topic.posts.build
    else
      @post = @topic.posts.first
    end
    if @post.images.empty?
      @post.images.build
    end
    render
  end
end
