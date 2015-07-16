require 'auto_html/filters/quote'

class Post < ActiveRecord::Base
  belongs_to :topic, inverse_of: :posts
  has_many :images, inverse_of: :post, dependent: :destroy

  nilify_blanks

  auto_html_for :content do
    html_escape
    quote
    youtube
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end

  validate :validate_content
  def validate_content
    if images.blank? && content.blank?
      errors.add(:base, 'Image or content is required')
    end
  end

  after_save :bump_topic
  def bump_topic
    topic.bump
  end
end
