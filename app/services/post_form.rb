class PostForm
  include ActiveModel::Model

  attr_accessor :topic, :post
  delegate :title, :board_id, to: :topic
  delegate :author, :content, :email, :topic_id, :images, :images_attributes=, to: :post

  # To be called right after new().
  # For rendering empty form.
  def from_topic(topic)
    @topic = topic
    setup_post
    self
  end

  # To be called right after new().
  # For params submitted from user.
  def from_params(params)
    if params[:topic_id].present?
      @topic = Topic.find(params[:topic_id])
    else
      @topic = Board.find(params[:board_id]).topics.build
    end
    @post = @topic.posts.build
    attributes(params)
    self
  end

  def setup_post
    @post = @topic.posts.build
    if @post.images.empty?
      @post.images.build
    end
  end

  def attributes(params)
    @post.assign_attributes(post_params(params))

    if new_topic?
      if params[:title]
        @topic.title = params[:title]
      end
      if params[:board_id]
        @topic.board_id = params[:board_id]
      end
    end
  end

  def valid?
    @post.valid? && @topic.valid?
  end

  def new_topic?
    !@topic.persisted?
  end

  def save
    return false if !valid?

    ActiveRecord::Base.transaction do
      @post.save! if @post.changed?
      @topic.save! if new_topic?
    end

    true
  rescue ActiveRecord::RecordInvalid => invalid
    false
  end

  def post_params(params)
    params.permit(:author, :content, :email, :topic_id, images_attributes:[:image, :remote_image_url])
  end

  # Necessary code

  def self.model_name
    ActiveModel::Name.new(self, nil, 'Post')
  end

  class << self
    def i18n_scope
      :activerecord
    end
  end
end

