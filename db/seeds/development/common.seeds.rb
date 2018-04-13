# frozen_string_literal: true

b = Board.first
if b.topics.empty?
  topic = b.topics.create(title: 'topic title goes here')
  3.times do
    topic.posts.create(content: 'post content goes here')
  end
end
