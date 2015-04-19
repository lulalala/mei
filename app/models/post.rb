class Post < ActiveRecord::Base
  belongs_to :topic, inverse_of: :posts
  has_many :images, inverse_of: :post

  accepts_nested_attributes_for :images

  after_save :bump_topic
  def bump_topic
    now = Time.now
    changes = {updated_at:now}
    changes[:bumped_at] = now
    topic.update_columns(changes)
  end
end
