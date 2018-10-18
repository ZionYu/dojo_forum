class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :avatar, ImageUploader

  has_many :posts, dependent: :destroy 

  has_many :replies, dependent: :restrict_with_error
  has_many :post_replies, through: :replies 

  has_many :vieweds, dependent: :restrict_with_error
  has_many :viewed_posts, through: :vieweds, source: :post
  
  def admin?
    self.role == "Admin"
  end
  
end
