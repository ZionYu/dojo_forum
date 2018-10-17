class Category < ApplicationRecord
  validates_presence_of :name
  has_many :post_categories, dependent: :restrict_with_error
end
