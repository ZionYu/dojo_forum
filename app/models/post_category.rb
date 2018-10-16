class PostCategory < ApplicationRecord
  belongs_to :post_id
  belongs_to :category_id
end
