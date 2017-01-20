module Portfolio
  class BaseController < ApplicationController
    before_action :require_login
    before_action :authorize_artist

    JS_ASSETS = %w(application portfolio_series portfolio_artworks).freeze

    private

    def authorize_artist
      if current_user.artist?
        @user = UserDecorator.new(current_user)
      else
        redirect_to root_path, alert: 'Only artists can access this page'
      end
    end

  end
end
