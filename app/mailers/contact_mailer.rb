class ContactMailer < ApplicationMailer

  def interest(params = {})
    @interest = params[:interest]
    mail from: params[:email], to: ADMIN_MAIL, subject: "[Interest Form] #{params[:title]} #{params[:name]}"
  end

  def enquiry(params = {})
    @name = params[:name]
    @message = params[:message]
    @vocation = params[:vocation]
    mail from: params[:email], to: ADMIN_MAIL, subject: "[Enquiry Form] #{params[:subject]}"
  end

end
