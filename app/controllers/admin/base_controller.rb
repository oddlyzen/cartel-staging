module Admin
  class BaseController < ApplicationController

    JS_ASSETS = %w(application admin_companies).freeze

    before_action :require_login
    before_action :authorize_admin!

    private

    def authorize_admin!
      if current_user.admin?
        @admin = current_user
      else
        redirect_to root_path, alert: 'Only admin can access this page'
      end
    end

  end
end
