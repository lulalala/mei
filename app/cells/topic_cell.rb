class TopicCell < Cell::Rails
  def show(topic)
    @topic = topic
    render
  end
end
