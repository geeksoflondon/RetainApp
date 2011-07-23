class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :current_user, :logged_in?, :admin?
  helper_method :display_notice?, :current_user, :logged_in?, :admin?, :require_attendee
  
  private 
  
  def display_notice?
    if flash[:notice] || flash[:errors]
      return true
    end
  end

  def require_login 
    unless logged_in?
      cookies[:auth_token] = request.url unless request.xhr?
      redirect_to login_url
    end
  end

  def require_admin
    require_login unless logged_in?
    redirect_to root_url, :notice => "You need to be an admin to get access to this feature" unless admin? || !logged_in?
  end

  def require_attendee
    require_login unless logged_in?
    redirect_to root_url, :notice => "You are not an attendee, Sorry!" unless attendee? || !logged_in?
  end

  def current_user
    @current_user ||= load_current_user
  end

  def logged_in?
    @logged_in = !@current_user.nil?
  end

  def admin?
    @admin = logged_in? && @current_user.is_admin
  end
  
  def attendee?
    @attendee = @current_user.is_attendee
  end
  
  def load_current_user
    if cookies[:auth_token]
      begin
        return User.find_by_auth_token(cookies[:auth_token])
      rescue
        return nil
      end
    else
      return nil
    end
  end
end
