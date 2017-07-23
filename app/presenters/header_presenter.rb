class HeaderPresenter

  def initialize(current_user)
    @user = current_user
  end

  def pending_collaborations
    @user.pending_collaborations.includes(:user)
  end

  def pending_friend_requests
    @user.pending_passive_friends
  end

  def pending_memberships
    CompanyMembership.where(company: @user.companies).pending.eager_load(:company, :user)
  end

  def notification_count
    pending_friend_requests.count + pending_memberships.count
  end

  def notifications?
    pending_friend_requests.blank? && pending_memberships.blank? ? false : true
  end

  def pending_event_notifications
    @user.event_notifications.pending
  end

end
