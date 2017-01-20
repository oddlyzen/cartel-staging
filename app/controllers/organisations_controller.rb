class OrganisationsController < ApplicationController
  before_action :set_user, only: [:index]

  def index
    @companies = @user.companies
  end

  private

  def set_user
    user = User.find(params[:artist_id] || params[:professional_id])
    @user = UserDecorator.new(user)
  end

end
