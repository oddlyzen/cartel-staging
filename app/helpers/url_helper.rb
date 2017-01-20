module UrlHelper
  def external_url(url)
    sanitize_url(url)
  end

  private

  def sanitize_url(url)
    uri = URI.parse(url)
    if %w(http https).include?(uri.scheme)
      uri.to_s
    else
      "http://#{uri}"
    end
  end

end
