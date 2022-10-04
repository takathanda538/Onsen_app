class Post < ApplicationRecord
  belongs_to :customer

  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_customers, through: :likes, source: :customer

  has_many_attached :post_images

  def liked_by?(user)
    likes.exists?(customer_id: user.id)
  end
end
