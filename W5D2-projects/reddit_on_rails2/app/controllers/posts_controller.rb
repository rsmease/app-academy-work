class PostsController < ApplicationController
  before_action :require_active_session

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id

    @post.save
    flash[:errors] = @post.errors.full_messages
    redirect_to subreddit_url(@post.subreddits.first)
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  def update
    @post = Post.find(params[:id])

    @post.update_attributes(post_params)
    flash[:errors] = @post.errors.full_messages
    redirect_to subreddit_url(@post.subreddits.first)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to subreddit_url(@post.subreddits.first)
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :content, subreddit_ids: [])
  end


end
