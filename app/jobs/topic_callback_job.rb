# frozen_string_literal: true

# Contains all the topic related callbacks,
class TopicCallbackJob < ActiveJob::Base
  queue_as :default

  def perform(topic)
    PruneJob.new.perform(topic.board)
  end
end
