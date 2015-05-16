class Post < ActiveRecord::Base
  belongs_to :topic, inverse_of: :posts
  has_many :images, inverse_of: :post, dependent: :destroy

  accepts_nested_attributes_for :images, reject_if: proc{|attributes|
    attributes.values_at(:remote_image_url, :image).all? &:blank?
  }

  nilify_blanks

  validate :validate_content
  def validate_content
    if images.blank? && content.blank?
      errors.add(:base, 'Image or content is required')
    end
  end

  after_save :bump_topic
  def bump_topic
    now = Time.now
    changes = {updated_at:now}
    changes[:bumped_at] = now
    topic.update_columns(changes)
  end
end
