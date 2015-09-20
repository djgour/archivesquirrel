class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: "Account successfully created!"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(update_user_params)
      redirect_to @user, notice: "Changes saved."
    else
      render :new
    end

  end

  private

  def user_params
    params.require(:user).permit(:name, :login, :email, :password, :password_confirmation, :description)
  end

  def update_user_params
    #doesn't let the user change their username
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :description)
  end

end
