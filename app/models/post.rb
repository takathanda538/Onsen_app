class Post < ApplicationRecord
  belongs_to :customer
  has_many_attached :post_images
end
