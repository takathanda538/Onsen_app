class PostComment < ApplicationRecord
  
  validates :comment, presence: true
  
  has_many :notifications, dependent: :destroy
  belongs_to :customer
  belongs_to :post
end
