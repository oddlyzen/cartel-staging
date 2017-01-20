module UserHelper
  def profile_path_for(user)
    if user.artist?
      link_to('Back to Profile', artist_path(user), class: 'btn btn-secondary pull-right', type: 'button')
    elsif user.professional?
      link_to('Back to Profile', professional_path(user), class: 'btn btn-secondary pull-right', type: 'button')
    end
  end

  def full_name(user)
    "#{user.first_name} #{user.last_name}"
  end

  def link_to_social_media(user, social_media, suffix = nil)
    return unless user.send("#{social_media}_link?")
    icon = [social_media, suffix].reject(&:blank?).join('-')
    link_to fa_icon(icon), user.send("#{social_media}_link").prepend('http://')
  end

  def university_location(education_record)
    education_record.state.present? ? education_record.state + ', ' + education_record.country : education_record.country
  end

  def profile_image_url(user, width, height, fit)
    return "#{user.profile_image_url}/convert?w=#{width}&h=#{height}&fit=#{fit}" if user.profile_image_url.present?
    email_to_gravatar(user.email)
  end

end
