module Personalization
  include Contracts

  Contract None => Bool
  def user_signed_in?
    current_user.present?
  end

  Contract None => Maybe[User]
  def current_user
    user_id = session[:user_id]
    User.find_by(id: user_id) if user_id.present?
  end


  Contract User => Any
  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out_current_user
    session.delete(:user_id)
  end
end