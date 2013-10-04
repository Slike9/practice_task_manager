class UserObserver < ActiveRecord::Observer

  def after_commit(user)
    UserMailer.registration_email(user).deliver if user.just_registered?
  end
end