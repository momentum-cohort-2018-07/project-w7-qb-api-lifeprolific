class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }
  helper_method :current_user
  helper_method :logged_in?
  helper_method :authenticate_token

  protected

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def authenticate_token
    User.find_by api_token: ActionController::HttpAuthentication::Token.token_and_options(request)[0]
  end

end