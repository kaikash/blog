class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :current_user
  # check_authorization

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :notice => exception.message
  end

  def current_user
    @current_user ||= (session[:current_user_id] && User.find(session[:current_user_id]))
  end

  private
  def authed_closed
    if current_user
      raise CanCan::AccessDenied.new 'already authinticated!'
    end
  end
end
