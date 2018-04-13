# frozen_string_literal: true

# A topic is a discussion point that posts can be nested under
class Topic < ApplicationRecord
  belongs_to :board, inverse_of: :topics
  has_many :posts, inverse_of: :topic, dependent: :destroy

  nilify_blanks

  before_create :set_bumped_at
  def set_bumped_at
    self.bumped_at = Time.now
  end

  after_commit :queue_after_commit_callback, on: :create
  def queue_after_commit_callback
    TopicCallbackJob.perform_later self
  end

  def bump
    now = Time.now
    update_columns(
      updated_at: now,
      bumped_at: now
    )
  end

  def increment_pos
    update_columns(
      max_pos: max_pos + 1
    )
  end
end
