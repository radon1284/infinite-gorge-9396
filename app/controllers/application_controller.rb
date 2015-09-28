class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  rescue_from CanCan::AccessDenied do | exception | 
    flash[:error] = exception.message 
    redirect_to root_url
  end 

	before_filter :set_timezone
  # before_filter :require_login

	def set_timezone
	   	Time.zone = 'GMT'
	end

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  protected
  # def authenticate_user!
  #   if user_signed_in?
  #     dashboard_path
  #   else
  #     redirect_to login_path, :notice => 'if you want to add a notice'
  #     ## if you want render 404 page
  #     ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
  #   end
  # end

  # def require_login
  #   unless current_user
  #     redirect_to new_user_session_path
  #   end
  # end
  
end
