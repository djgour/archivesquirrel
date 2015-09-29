class SessionsController < ApplicationController

  def new
  end

  def create
    user =  if params[:login_or_email] =~ /@/
              User.find_by(email: params[:login_or_email])
            else
              User.find_by(login: params[:login_or_email])
            end
    if user && user.authenticate(params[:password])
      log_in user
      flash[:notice] = "You have successfully logged in!"
      redirect_to(session[:intended_url] || user)
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
