class Post < ApplicationRecord
  belongs_to :customer
  
  has_many :post_comments, dependent: :destroy
  
  has_many_attached :post_images
  
  def get_post_images(width, height)
    unless post_images.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      post_images.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      post_images.variant(resize_to_limit: [width, height]).processed
  end
end
