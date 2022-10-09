class Post < ApplicationRecord
  belongs_to :customer

  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_customers, through: :likes, source: :customer

  has_many_attached :post_images
  
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("name LIKE?","#{word}")
    elsif search == "forward_match"
      @post = Post.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @post = Post.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @post = Post.where("name LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end

  def liked_by?(user)
    likes.exists?(customer_id: user.id)
  end
end
