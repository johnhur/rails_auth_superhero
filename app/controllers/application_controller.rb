class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def confirm_logged_in
  	unless session[:user_id]
  		redirect_to login_path, alert: "Please log in"
  	end
  end

  def prevent_login_signup
    if session[:user_id]
      redirect_to home_path, notice: "You are already logged in"
      # what do you think redirect_to :back does?
    end
  end

   def current_user
   # Let's not make a database query if we don't need to!
    return unless session[:user_id]
   # Defines @current_user if it is not already defined.
    @current_user ||= User.find_by_id(session[:user_id])
  end

helper_method :current_user
end
