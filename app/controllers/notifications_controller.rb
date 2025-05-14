class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.most_recent_first
    @notifications.unread.update_all(read_at: Time.current)
  end
end
