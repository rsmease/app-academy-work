class SessionsController < ApplicationController

  def show
    redirect_to new_session_url
  end

  def new
    #create corresponding view
    render :new
  end

  def create
    #forget what goes here...
    user = User.find_by_credentials(session_params[0], session_params[1])

    if user.nil?
      flash.now[:errors] = ["Invalid email or password."]
      render :new
    else
      log_in!(user)
      redirect_to user_url(user)
    end
  end

  def destroy
    #need to write this method
    log_out!
    redirect_to root_url
  end

  private

  def session_params
    [params[:user][:email], params[:user][:password]]
  end

end
