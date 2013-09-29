class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:email, :password, :password_confirmation)
    @user = User.new(user_params)
    if @user.save
      redirect_to root_url, notice: t('flashes.user.registered')
    else
      render :new
    end
  end
end
