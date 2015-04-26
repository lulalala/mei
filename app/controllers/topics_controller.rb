class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :destroy]

  # GET /topics
  def index
    @topics = @board.topics.order(bumped_at: :desc).page(params[:page]).per(5)
  end

  # GET /topics/1
  def show
  end

  # POST /topics
  def create
    @topic = Topic.new(topic_params)

    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
        format.json {
          render json: {
            success: true,
            redirect_to: topic_path(@topic)
          }
        }
      else
        format.html { render :new }
        format.json {
          flash[:error] = @topic.errors.full_messages.join('<br/>').html_safe
          render json: {
            success: false
          }
        }
      end
    end
  end

  # DELETE /topics/1
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
    end
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_topic
    @topic = Topic.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def topic_params
    params.require(:topic).permit(:title, :board_id, posts_attributes: [:author, :content, :email, images_attributes:[:image, :remote_image_url]])
  end
end
