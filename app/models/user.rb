class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :avatar, ImageUploader

  has_many :posts, dependent: :destroy 

  has_many :replies, dependent: :restrict_with_error
  has_many :replied_posts, through: :replies, source: :post

  has_many :collects, dependent: :destroy
  has_many :collected_posts, through: :collects, source: :post

  has_many :vieweds, dependent: :restrict_with_error
  has_many :viewed_posts, through: :vieweds, source: :post
  
  def admin?
    self.role == "Admin"
  end
  
end
