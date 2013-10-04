class UserObserver < ActiveRecord::Observer

  def after_register(user, transition)
    UserMailer.registration_email(user).deliver
  end
end