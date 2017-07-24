class UsersController < ApplicationController
  attr_reader :user
  def show
    @user = User.find(params[:id])
    return if user
    flash[:danger] = t "not_exit_user"
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if user.save
      flash[:success] = t "welcome_to_app"
      redirect_to user
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
end
