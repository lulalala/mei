class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :omitted, :destroy]

  # GET /topics
  def index
    @topics = @board.topics.order(bumped_at: :desc).page(params[:page]).per(5)
  end

  # GET /topics/1
  def show
  end

  # DELETE /topics/1
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: 'Topic was successfully destroyed.' }
    end
  end

  # GET /topics/1/omitted
  def omitted
    render layout:false
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_topic
    @topic = Topic.find(params[:id])
  end
end
