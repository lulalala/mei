require 'auto_html/filters/quote'

class Post < ActiveRecord::Base
  belongs_to :topic, inverse_of: :posts
  has_many :images, inverse_of: :post, dependent: :destroy

  serialize :options, Array

  nilify_blanks

  auto_html_for :content do
    html_escape
    quote
    youtube
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end

  delegate :board, to: :topic

  validate :validate_content
  def validate_content
    if images.blank? && content.blank?
      errors.add(:base, 'Image or content is required')
    end
  end

  def options_raw=(value)
    super

    analyzer = RawOptionsAnalyzer.new(options_raw, board.config.post.allowed_options)
    self.email = analyzer.email
    self.options = analyzer.options
    extend_options
  end

  before_create :set_pos
  def set_pos
    self.pos = topic.max_pos + 1
  end

  after_create :bump_topic
  def bump_topic
    topic.bump
  end

  after_create :increment_topic_pos
  def increment_topic_pos
    topic.increment_pos
  end

private

  # Load post option modules to object's eigenclass.
  # This extends single object instance.
  def extend_options
    options.each do |option|
      klass = Post::Extension.const_get(option.camelize)
      self.extend klass
    end
  end
end
