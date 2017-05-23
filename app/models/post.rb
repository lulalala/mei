require 'auto_html/filters/quote'

class Post < ActiveRecord::Base
  belongs_to :topic, inverse_of: :posts
  has_many :images, inverse_of: :post, dependent: :destroy

  # Replies
  has_many :links_as_parent, foreign_key: :ancestor_id, class_name:'Reply'
  has_many :links_as_child, foreign_key: :descendant_id, class_name:'Reply'
  has_many :parents, through: :links_as_child, source: :ancestor
  has_many :children, through: :links_as_parent, source: :descendant

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

  validate :validate_topic_lock
  def validate_topic_lock
    if topic.locked?
      errors.add(:topic, :locked)
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

  before_save :assign_reply
  REPLY_PATTERN = /(\&gt; ?(\d+))/
  def assign_reply
    return if content_html.blank?

    pos_array = content_html.scan(REPLY_PATTERN).map{|m| m[1]}
    self.parents += Post.where(topic_id: topic_id, pos: pos_array)
  end

  before_save :extract_images
  def extract_images
    return if content_html.blank?
    return if !content_changed?

    content_html_dup = content_html.dup

    content.lines.each do |line|
      url = URI.extract(line)

      next if url.size != 1

      url = url.first
      next if (line.sub(url,'').strip).size > 0

      image = images.find_by(remote_image_url: url)
      if !image
        image = Image.create(remote_image_url: url)
        next if !image.valid?

        self.images << image
      end

      content_html_dup.gsub!(%r{<a.+?#{Regexp.quote(url)}.+?</a>}, image.presenter.cleared_linked_display)
    end

    self.content_html = content_html_dup
  end

  before_save :turn_reply_to_link
  def turn_reply_to_link
    return if content_html.blank?

    self.content_html = content_html.gsub(REPLY_PATTERN) do |match|
      pos = match[/\d+/].to_i
      r = parents.find {|parent| parent.pos == pos}
      if r
        url = Rails.application.routes.url_helpers.topic_path(
          board: r.topic.board,
          id: r.topic_id,
          anchor: r.presenter.dom_id
        )
        ActionController::Base.helpers.link_to("> #{r.pos}", url)
      else
        match
      end
    end
  end

  # TODO: check in before_save to block uploading
  after_create :update_file_attachable
  def update_file_attachable
    if Image.joins(:post => :topic).where(:post => {:topic => topic}).count > 100
      topic.update_columns(file_attachable: false)
    end
  end
end
