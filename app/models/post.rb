class Post < ApplicationRecord

  mount_uploader :image, ImageUploader

  belongs_to :user

  has_many :replies, dependent: :destroy
  has_many :replied_users, through: :replies, source: :user

  has_many :collects, dependent: :destroy
  has_many :collected_users, through: :collects, source: :user
  
  has_many :vieweds, dependent: :destroy
  has_many :veiwed_users, through: :vieweds, source: :user

  has_many :post_categories ,dependent: :destroy
  has_many :categories, through: :post_categories
  

  def self.published
    where(status: "published").all
  end
 
  
  def self.drafts
    where(:status => "draft").all
  end

  def is_collected?(user)
    self.collected_users.include?(user)
  end

  def pageviews
    self.viewed_count += 1
    save!
  end

end
