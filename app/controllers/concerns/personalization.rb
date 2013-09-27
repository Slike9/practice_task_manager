module Personalization
  def user_signed_in?
    current_user.present?
  end

  def current_user
    user_id = session[:user_id]
    User.find(user_id) if user_id.present?
  end

  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out_current_user
    session.delete(:user_id)
  end
end