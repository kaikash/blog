class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :current_user


  rescue_from Exception, with: :render_error
  rescue_from CanCan::AccessDenied, with: :access_denied
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found   
  rescue_from ActionController::RoutingError, with: :render_not_found
  
  def current_user
    @current_user ||= (session[:current_user_id] && User.find_by_id(session[:current_user_id]))
    unless @current_user
      session.delete :current_user_id 
    end
    @current_user
  end

  private
  def authed_closed
    if current_user
      raise CanCan::AccessDenied.new 'You are already authinticated.'
    end
  end
end
