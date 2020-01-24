class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  mount_uploader :profile_image, ProfileImageUploader
  has_many :articles
  has_many :likes
  has_many :stocks
  has_many :comments
  has_many :notifications

  validates :username, presence: true, uniqueness: { case_sensitive: true }, format: { with: /\A[0-9a-zA-Z@_-]{6,}\z/ }
  validates :email, presence: true, uniqueness: { case_sensitive: true }

  acts_as_paranoid
end
