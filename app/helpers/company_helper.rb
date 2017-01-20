module CompanyHelper

  def image_url(company, width, height, fit)
    return "#{company.image_url}/convert?w=#{width}&h=#{height}&fit=#{fit}" if company.image_url.present?
    email_to_gravatar(company.owner.email)
  end

end
