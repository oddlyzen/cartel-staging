class FeedItemDecorator < BaseDecorator

  def initialize(feed_item)
    @user = UserDecorator.new(feed_item.user)
    super(feed_item)
  end

  def user_name
    @user.full_name
  end

  def time
    @model.created_at.strftime('%e %b, %l:%M%P')
  end

end
