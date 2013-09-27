class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :user_signed_in?, :current_user

  def user_signed_in?
    current_user.present?
  end

  def current_user
    user_id = session[:user_id]
    User.find(user_id) if user_id.present?
  end

  def sign_in(user_data)
    user = User.find_by_email(user_data[:email])
    if user.present? && user.authenticate(user_data[:password])
      session[:user_id] = user.id
    end
  end

end
