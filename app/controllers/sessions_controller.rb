class SessionsController < ApplicationController
  def new

  end

  def create
    user_data = params[:user_data]
    sign_in(user_data)
    if user_signed_in?
      redirect_to root_url
    else
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end
