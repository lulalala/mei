class TopicCell < Cell::Rails
  def show(topic, omit:false)
    @topic = topic

    @omit = omit && Omit.omit?(
      topic.posts.size - 1,
      topic.board.reply_omit_condition.n_recent_only,
      topic.board.reply_omit_condition.avoid_only_n_hidden
    )

    render
  end
end
