class Category < ApplicationRecord
  validates_presence_of :name
  has_many :post_categories
end
