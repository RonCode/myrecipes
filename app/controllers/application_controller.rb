class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # allows for availability in "Views" folder files
  helper_method :current_user, :logged_in?
  
  def current_user
    # mamalization for performance, will use current_user 
    # instead of hitting database every time, adds efficiency 
    @current_user ||= Chef.find(session[:chef_id]) if session[:chef_id]   
  end
  
  def logged_in?
    !!current_user
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "Your must be logged in to perform that action"
      redirect_to :back
    end
  end
end
