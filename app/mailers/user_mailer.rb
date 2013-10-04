class UserMailer < ActionMailer::Base
  default from: configus.admin_email

  def registration_email(user)
    @user = user
    mail(to: @user.email)
  end
end