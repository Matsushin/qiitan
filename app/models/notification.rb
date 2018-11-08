class Notification < ApplicationRecord
  WIDGET_DISPLAY_COUNT = 5
  belongs_to :notifiable, polymorphic: true
  belongs_to :user

  validates :user_id, uniqueness: { scope: %i[notifiable_id notifiable_type] }

  scope :unread, -> { where(read_at: nil) }

  def read?
    read_at.present?
  end

  def unread?
    !read?
  end

  def read
    touch(:read_at)
  end
end
