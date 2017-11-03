require 'net/http'
require 'json'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :require_active_session
  helper_method :logged_in?
  helper_method :random_corgi_url

  def current_user
    return nil if session[:session_token].nil?
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !current_user.nil?
  end

  def login!(user)
    session[:session_token] = user.reset_session_token!
  end

  def logout!
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def require_active_session
    unless logged_in?
      redirect_to new_session_url
    end
  end

  def random_corgi_url
    url = "https://api.giphy.com/v1/gifs/random?api_key=WowLIPJbsZymHSrRfupBUX9hdPH0AB13&tag=corgi&rating=R"
    resp = Net::HTTP.get_response(URI.parse(url))
    buffer = resp.body
    result = JSON.parse(buffer)
    result["data"]["image_original_url"]
  end

end
