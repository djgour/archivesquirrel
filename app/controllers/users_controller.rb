class UsersController < ApplicationController

  before_action :require_login, except: [:new, :create]
  before_action :require_correct_user, only: [:edit, :update]

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
      log_in @user
      redirect_to @user, notice: "Account successfully created!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(update_user_params)
      redirect_to @user, notice: "Changes saved."
    else
      render :new
    end
  end

  def destroy
    #remember to automatically sign a user out when implementing this
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
