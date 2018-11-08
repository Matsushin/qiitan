class Like < ApplicationRecord
  belongs_to :user
  belongs_to :article
  has_many :notifications, dependent: :destroy, as: :notifiable, inverse_of: :notifiable

  validates :user_id, uniqueness: { scope: :article_id }
end