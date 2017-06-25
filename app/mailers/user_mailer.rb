class UserMailer < ApplicationMailer

  def registration_confirmation(user)
     @user = user
     mail(:to => user.email, :subject => "Registration Confirmation")
  end

  def reset_password_email(user)
    @user = User.find user.id
    @url  = edit_password_reset_url(@user.reset_password_token)
    mail(to: user.email, subject: 'Reset password email')
  end
end
