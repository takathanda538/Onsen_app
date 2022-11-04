class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  validates :name, presence: true, length: { minimum: 1, maximum: 20 }
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :post_comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post
  has_many :following, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following_customer, through: :following, source: :follower # 自分がフォローしている人
  has_many :follower_customer, through: :follower, source: :following # 自分をフォローしている人
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :rooms, through: :entries
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  has_one_attached :profile_image
  has_many_attached :post_images
  
  
  def follow(user_id)
    following.create(follower_id: user_id)
  end
  
  def unfollow(user_id)
    following.find_by(follower_id: user_id).destroy
  end
  
  def following?(user)
    following_customer.include?(user)
  end

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "guestuser"
    end
  end
  
  def create_notification_follow!(current_customer)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_customer.id, id, 'follow'])
    if temp.blank?
      notification = current_customer.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

end
