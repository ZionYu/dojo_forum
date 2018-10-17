class Post < ApplicationRecord
  belongs_to :user

  has_many :replies, dependent: :destroy
  
  has_many :vieweds, dependent: :destroy
  has_many :veiwed_users, through: :vieweds, source: :user

  has_many :post_categories
  has_many :categories, through: :post_categories
end
