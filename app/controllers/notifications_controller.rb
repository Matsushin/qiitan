class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.order(created_at: :desc).page(params[:page])
  end

  def read_all
    current_user.notifications.unread.update_all(read_at: Time.current)
  end
end