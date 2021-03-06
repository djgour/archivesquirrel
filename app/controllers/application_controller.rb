class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper


  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def current_user?(user)
    current_user == user
  end

  helper_method :current_user?
  
  def find_user_by_login_or_email(login_or_email)
    if login_or_email =~ /@/
      User.find_by(email: login_or_email)
    else
      User.find_by(login: login_or_email)
    end
  end
  
  helper_method :find_user_by_login_or_email

  def require_login
    unless current_user
      session[:intended_url] = request.url
      redirect_to login_path, alert: "This action requires you to log in."

    end
  end

  def require_correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user == @user
  end
  
  def require_project_member
    @project = Project.find(params[:project_id])
    unless @project.project_member?(current_user)
      redirect_to root_url, notice: "You are not authorized to do this."
    end
  end

end
