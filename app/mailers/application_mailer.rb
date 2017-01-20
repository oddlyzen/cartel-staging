class ApplicationMailer < ActionMailer::Base

  ADMIN_MAIL = (User.where(role: 0).first&.email || ENV['ADMIN_MAIL'])

  default from: ADMIN_MAIL

  layout 'mailer'

end
