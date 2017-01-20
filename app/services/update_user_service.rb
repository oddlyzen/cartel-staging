class UpdateUserService

  UpdateUserResult = Struct.new(:user, :feed_item)

  def initialize(user, attributes = {})
    @user = user
    @user_last_updated_at = @user.updated_at
    @attributes = attributes
    @result = ServiceCall.new(UpdateUserResult)
  end

  def call
    update_user and trigger_new_user_update_feed_item
    @result
  end

  private

  def update_user
    form = My::ProfileForm.new(@user, @attributes)
    @result.data.user = form.user
    @result.errors += form.errors.full_messages unless form.save
    @result.success?
  end

  def trigger_new_user_update_feed_item
    return unless user_updated?
    @result.data.feed_item = FeedItem.create(
      user: @user,
      kind: :user_update
    )
  end

  def user_updated?
    @user.reload.updated_at > @user_last_updated_at
  end

end
