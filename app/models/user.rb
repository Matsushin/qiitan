class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :articles, dependent: :destroy

  validates :username, presence: true, uniqueness: true, format: { with: /\A[0-9a-zA-Z@_-]{6,}\z/ }
  validates :email, presence: true
end
