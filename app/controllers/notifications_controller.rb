class NotificationsController < ApplicationController
  before_action :set_notification, only: %i(read)

  def index
    @notifications = current_user.notifications.includes(notifiable: :user).order(created_at: :desc).page(params[:page])
  end

  def read
    if @notification.read
      head :ok
    else
      render js: "alert('#{t('common.flash.fail.read')}')"
    end
  end

  def read_all
    current_user.notifications.unread.update_all(read_at: Time.current)
    redirect_to notifications_path, notice: t('common.flash.updated')
  end

  private

  def set_notification
    @notification = current_user.notifications.find(params[:id])
  end
end