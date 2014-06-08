class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate
    redirect_to root_url, alert: 'Bitte log dich zu erst ein.' if current_user.nil?
  end

  def authorize user_id
    if user_id.to_i == current_user.id
      return true
    else
      redirect_to root_url, alert: 'Nicht erlaubt.'
    end
  end

end