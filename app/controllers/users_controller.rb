class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index ,:edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user , only: :destroy
  def new
    @user = User.new
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def show 
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      log_in @user
    # Handle a successful save.
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    # Handle a successful update.
      flash[:success] = "Profile has successfully updated"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def admin_user 
    redirect_to root_path unless current_user.admin?
  end

  #check if a user is logged or not, if not, redirect to the login path
  def logged_in_user
    unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
    end
  end

  # if current_user try to change the other is not permit
  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)
  end
end
