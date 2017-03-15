module ApplicationHelper

  def user_profile_path(user)
    if user.role == 'artist'
      artist_path(user.id)
    else
      professional_path(user.id)
    end
  end

  def bootstrap_class_for(flash_type)
    string_for(flash_type)[:class]
  end

  def flash_icon_for(flash_type)
    string_for(flash_type)[:icon]
  end

  def options_for_enum(hash)
    hash.map { |k, _v| [k.humanize, k] }
  end

  def options_for_array(array)
    array.map { |k, _v| [k.humanize, k] }
  end

  def external_link(obj)
    obj.link ? (link_to obj.title || 'Untitled', 'http://' + obj.link) : obj.title
  end

  def external_link_with_name(obj, name)
    obj.link ? (link_to name, 'http://' + obj.link) : ''
  end

  def active_if(paths)
    if paths.any? { |path| current_page?(path) }
      'active'
    else
      ''
    end
  end

  def email_to_gravatar(email)
    "https://gravatar.com/avatar/#{Digest::MD5.hexdigest(email.downcase)}.png?s=96&d=mm"
  end

  def company_image(company)
    return email_to_gravatar(company.email) if company.image_url.blank?
    company.image_url + '/convert?w=128&h=128&fit=crop'
  end

  def body_data
    {}.tap do |data|
      data[:view]  = "#{controller_path}##{action_name}"
      data[:debug] = 'true' if Rails.env.development?
    end
  end

  def body_css_class
    controller_name = controller_path.underscore.tr('/', '-')
    "#{controller_name} #{controller_name}-#{css_action_name}"
  end

  def css_action_name
    action = action_name
    case action
    when 'update'
      'edit'
    when 'create'
      'new'
    else
      action
    end.tr('_', '-')
  end

  private

  def string_for(flash_type)
    case flash_type.to_sym
    when :success, :notice
      { class: 'alert-success' }
    when :error, :alert
      { icon: 'ban', class: 'alert-danger' }
    when :info
      { icon: 'info', class: 'alert-info' }
    else
      { icon: 'warning', class: 'alert-warning' }
    end
  end
end
