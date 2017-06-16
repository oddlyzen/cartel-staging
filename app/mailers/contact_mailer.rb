class ContactMailer < ApplicationMailer

  def interest(params = {})
    @interest = params[:interest]
    @name = params[:name]
    @attachment = params[:attachment]
    @email = params[:email]
    @message = params[:message]

    mail from: params[:email], to: "admin@artcartel.io", subject: "[Interest Form] #{params[:interest]} - #{params[:title]} #{params[:name]}"
  end

  def enquiry(params = {})
    @name = params[:name]
    @message = params[:message]
    @vocation = params[:vocation]
    mail from: params[:email], to: ADMIN_MAIL, subject: "[Enquiry Form] #{params[:subject]}"
  end

end
