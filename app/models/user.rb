class User < ApplicationRecord
  has_many :pictures
  has_many :favorites, dependent: :destroy
  has_many :favorite_pictures, through: :favorites, source: :picture
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, length: { minimum: 6 }
  mount_uploader :image, ImageUploader
end
