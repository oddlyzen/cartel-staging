module My
  class BaseController < ApplicationController

    JS_ASSETS = %w(application my_companies my_connections my_profiles my_settings).freeze

    before_action :require_login
    before_action :prepare_user

    private

    def prepare_user
      @user = current_user
    end

  end
end
