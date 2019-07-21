class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  mount_uploader :profile_image, ProfileImageUploader
  has_many :articles, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :stocks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :username, presence: true, uniqueness: true, format: { with: /\A[0-9a-zA-Z@_-]{6,}\z/ }
  validates :email, presence: true, uniqueness: true

  acts_as_paranoid
end
