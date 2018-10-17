class Post < ApplicationRecord

  mount_uploader :image, ImageUploader

  belongs_to :user

  has_many :replies, dependent: :destroy
  
  has_many :vieweds, dependent: :destroy
  has_many :veiwed_users, through: :vieweds, source: :user

  has_many :post_categories ,dependent: :destroy
  has_many :categories, through: :post_categories
  
end
