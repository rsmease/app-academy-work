class SubredditsController < ApplicationController
  before_action :require_active_session, except: [:index]

  def index
    @subreddits = Subreddit.all
    render :index
  end

  def new
    render :new
  end

  def create
    @subreddit = Subreddit.new(subreddit_params)
    @subreddit.moderator_id = current_user.id

    if @subreddit.save
      redirect_to subreddit_url(@subreddit)
    else
      flash.now[:errors] = @subreddit.errors.full_messages
      render :new
    end
  end

  def show
    @subreddit = Subreddit.find(params[:id])
    render :show
  end

  def edit
    @subreddit = Subreddit.find(params[:id])
    render :edit
  end

  def update
    @subreddit = Subreddit.find(params[:id])

    @subreddit.update_attributes(subreddit_params)
    flash[:errors] = @subreddit.errors.full_messages
    redirect_to subreddit_url(@subreddit)
  end

  def destroy
    @subreddit = Subreddit.find(params[:id])
    @subreddit.destroy
    redirect_to root_url
  end

  private
  def subreddit_params
    params.require(:subreddit).permit(:title, :description)
  end

end
