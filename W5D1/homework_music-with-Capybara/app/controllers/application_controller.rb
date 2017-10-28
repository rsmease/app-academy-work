class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :logged_out?, :random_ryan_url

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def log_in!(user)
    session[:session_token] = user.reset_session_token!
  end

  def log_out!
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def logged_in?
    !!current_user
  end

  def logged_out?
    return true unless session[:session_token]
  end

  def confirm_logged_in
    unless logged_in?
      redirect_to new_session_url
    end
  end

  def confirm_logged_out
    unless logged_out?
      redirect_to user_url(current_user)
    end
  end

  def random_ryan_url
    # require 'net/http'
    # require 'json'
    url = "https://api.giphy.com/v1/gifs/random?api_key=WowLIPJbsZymHSrRfupBUX9hdPH0AB13&tag=ryan gosling&rating=PG-13"
    resp = Net::HTTP.get_response(URI.parse(url))
    buffer = resp.body
    result = JSON.parse(buffer)
    result["data"]["image_original_url"]
  end

end
