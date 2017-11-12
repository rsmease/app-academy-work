class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if user
      login(user)
      redirect_to root_url
    else
      flash.now[:errors] = user.errors.full_messages
      render :new
    end
  end

  def destroy
    signout!
    redirect_to root_url
  end
end
