class NetworksController < ApplicationController
  before_action :set_user, only: [:index]

  def index
    @friends = @user.friends.map { |user| UserDecorator.new(user) }
  end

  private

  def set_user
    user = User.find(params[:artist_id] || params[:professional_id])
    @user = UserDecorator.new(user)
  end

end
