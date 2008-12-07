# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_untitled6_session_id'
  before_filter :authorize
  protected
  
  # Override in controller classes that should require authentication
  def secure?
    false
  end
  
  private
  def authorize
    if secure? && session[:user_id].nil?
      session[:return_to] = request.request_uri
      redirect_to :controller => "login", :action => "login"
      return false
    end
  end
end
