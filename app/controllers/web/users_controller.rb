class Web::UsersController < Web::ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new
    respond_with(@user)
  end

  def create
    @user = User.new(user_params)
    @user.register
    respond_with(@user, location: root_url)
  end

  def show
    respond_with(@user)
  end

  def edit
    respond_with(@user)
  end

  def update
    @user.update(user_params)
    respond_with(@user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :avatar, :remove_avatar, :avatar_cache)
  end
end
