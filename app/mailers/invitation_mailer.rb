class InvitationMailer < ApplicationMailer

  def invite(email, full_name, referrer)
    @link = new_registration_url(referrer_id: referrer.id)
    @full_name = full_name
    @email = email
    @referrer = referrer
    mail(to: email, subject: 'An Invitation to join Cartel')
  end

end
