class UsersController < ApplicationController

  def index
    if logged_in?
      redirect_to user_url(current_user)
    else
      redirect_to root_url
    end
  end

  def new
    render :new
  end

  def show
    @user = current_user
    render :show
  end

  def create
    @user = User.new(user_params)

    if @user.save
      #need to add this method
      flash[:notice] = "Your account is now available! Welcome to Mewsic. You will need to sign in to start listening. Please confirm your account clicking through the activation email that we have sent to your email address, #{@user.email}"
      #maybe change this later
      redirect_to new_session_url
    else
      #place errors in view
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
