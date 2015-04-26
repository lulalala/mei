class PostsController < ApplicationController
  before_action :set_post, only: [:destroy]

  # POST /posts
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post.topic, notice: 'Post was successfully created.' }
        format.json {
          render json: {
            success: true,
            redirect_to: topic_path(@post.topic)
          }
        }
      else
        format.html { redirect_to @post.topic }
        format.json {
          flash[:error] = @post.errors.full_messages.join('<br/>').html_safe
          render json: {
            success: false
          }
        }
      end
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
    end
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:content, :author, :email, :topic_id, images_attributes:[:image, :remote_image_url])
  end
end
