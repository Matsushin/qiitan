module ApplicationHelper
  def add_unread_style(unread)
    'is-unread' if unread
  end
end
