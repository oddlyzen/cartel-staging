module HttpReferer
  def self.included(base)
    base.class_eval do
      setup :setup_http_referer if respond_to?(:setup)
    end
  end

  def setup_http_referer
    @request.env['HTTP_REFERER'] = root_url
  end
end
