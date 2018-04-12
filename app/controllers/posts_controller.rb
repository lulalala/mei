class PostsController < ApplicationController
  before_action :set_post, only: [:destroy]

  # POST /posts
  # For creating new topic or replying
  def create
    @post_form = PostForm.new.from_params(params[:post])

    respond_to do |format|
      if @post_form.save
        flash[:notice] = 'Successfully created.'

        format.json {
          render json: {
            success: true,
            redirect_to: topic_path(@post_form.topic)
          }
        }
        format.html { redirect_to @post_form.topic }
      else
        flash[:error] = @post_form.errors.adequate.messages.join('<br/>').html_safe

        format.json {
          render json: {
            success: false
          }
        }
        format.html { redirect_to @post_form.topic }
      end
    end
  end

  # GET /posts for AJAX
  # For creating new topic or replying
  def new
    if params[:topic_id]
      @topic = Topic.find(params[:topic_id])
    elsif params[:board_id]
      @topic = Board.find(params[:board_id]).topics.new
    elsif params[:post_id]
      @topic = Topic.joins(:posts).find_by('posts.id' => params[:post_id])
    end

    render layout: false
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
end
