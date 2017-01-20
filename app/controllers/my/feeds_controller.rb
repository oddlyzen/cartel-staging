module My
  class FeedsController < My::BaseController
    def show
      friends = @user.friends
      feed_items = FeedItem.includes(:user, :artwork).where(user: friends).order(created_at: :desc)
      @feed_items = FeedItemDecorator.wrap_all(feed_items)
    end
  end
end
