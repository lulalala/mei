# frozen_string_literal: true

class PostForm
  include ActiveModel::Model

  attr_accessor :topic, :post
  delegate :title, :board_id, :file_attachable?, to: :topic
  delegate :author, :content, :options_raw, :topic_id, :images, :images_attributes=, to: :post

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
    @topic = if params[:topic_id].present?
               Topic.find(params[:topic_id])
             else
               Board.find(params[:board_id]).topics.build
             end
    @post = @topic.posts.build
    attributes(params)
    self
  end

  def setup_post
    @post = @topic.posts.build
    @post.images.build if @post.images.empty?
  end

  def attributes(params)
    @post.assign_attributes(post_params(params))

    @post.images.concat build_images_from_params(params)

    if new_topic?
      @topic.title = params[:title] if params[:title]
      @topic.board_id = params[:board_id] if params[:board_id]
    end
  end

  def build_images_from_params(params)
    images = []

    if params[:image_ids].present?
      images.concat Image.where(id: params[:image_ids], post_id: nil)
    end

    if params[:images].present?
      params[:images].each do |file|
        images << Image.new(image: file)
      end
    end

    images
  end

  def valid?
    validity = true
    errors.clear
    [post, topic].each do |object|
      next if object.valid?
      validity = false
      object.errors.adequate.each do |error|
        errors.adequate.import(error)
      end
    end
    validity
  end

  def new_topic?
    !@topic.persisted?
  end

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      @post.save! if @post.changed?
      @topic.save! if new_topic?
    end

    true
  rescue ActiveRecord::RecordInvalid => invalid
    false
  end

  def post_params(params)
    params.permit(:author, :content, :options_raw, :topic_id)
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
