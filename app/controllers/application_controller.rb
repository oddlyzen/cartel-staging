class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  JS_ASSETS = %w(application).freeze

  before_action :prepare_header_presenter

  def js_assets
    self.class::JS_ASSETS
  end

  private

  def prepare_header_presenter
    @header_presenter = HeaderPresenter.new(current_user)
  end

end
