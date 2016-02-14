class SessionsController < ApplicationController

  def new
  end

  def create
    user =  find_user_by_login_or_email(params[:login_or_email])
    if user && user.authenticate(params[:password])
      log_in user
      flash[:notice] = "You have successfully logged in!"
      redirect_to(session[:intended_url] || root_path )
      session[:intended_url] = nil
    else
      flash.now[:alert] = "Invalid email/password combination."
      render :new
    end

  end
  
  def destroy
    log_out
    redirect_to root_url, notice: "You are now logged out."
  end
end
