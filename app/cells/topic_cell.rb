# frozen_string_literal: true

# Cell for a Topic
class TopicCell < Cell::Rails
  def show(topic, omit: false)
    @topic = topic
    @posts = @topic.posts.order(id: :asc).includes(:images)
    @omit = omit && topic_omittable?(topic)

    render
  end

  def omitted(topic)
    @topic = topic

    return unless topic_omittable?(topic)

    limit = @topic.posts.size - 1 - @topic.board.reply_omit_condition[:n_recent_only]
    @posts = @topic.posts.order(id: :asc).includes(:images).offset(1).limit(limit)

    render
  end

  private

  def topic_omittable?(topic)
    Omit.omit?(
      topic.posts.size - 1,
      topic.board.reply_omit_condition.dig(:n_recent_only),
      topic.board.reply_omit_condition.dig(:avoid_only_n_hidden)
    )
  end
end
