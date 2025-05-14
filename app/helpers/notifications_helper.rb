module NotificationsHelper
  def unread_notifications(user)
    return if user.notifications.unread.empty?

    "unread-notifications"
  end
end
