class Web::SessionsController < Web::ApplicationController
  def new

  end

  def create
    user_data = params[:user_data]
    user = User.find_by(email: user_data[:email])
    if user.present? && user.authenticate(user_data[:password])
      sign_in(user)
      redirect_to root_url
    else
      render :new
    end
  end

  def destroy
    sign_out_current_user
    redirect_to root_url
  end

end
