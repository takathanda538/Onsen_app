class Post < ApplicationRecord

  validates :name, presence: true, length: { minimum: 1, maximum: 35 }
  validates :ride_area, presence: true
  validates :title, presence: true, length: { minimum: 1, maximum: 180 }
  validates :body, presence: true, length: { minimum: 1, maximum: 450 }

  belongs_to :customer

  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_customers, through: :likes, source: :customer
  has_many :notifications, dependent: :destroy
  has_many :tags, dependent: :destroy

  has_many_attached :post_images

  def self.looks(search, word)
    labels = Post.ride_areas.keys.grep(/#{word}/)
    values = labels.map(&Post.ride_areas)
    if search == "perfect_match"
      other_posts = Post.where("name LIKE ? OR title LIKE ? OR body LIKE?","#{word}", "#{word}", "#{word}")
    elsif search == "forward_match"
      other_posts = Post.where("name LIKE ? OR title LIKE ? OR body LIKE?","#{word}%", "#{word}%", "#{word}%")
    elsif search == "backward_match"
      other_posts = Post.where("name LIKE ? OR title LIKE ? OR body LIKE?","%#{word}", "%#{word}", "%#{word}")
    elsif search == "partial_match"
      ride_area_posts = Post.where('ride_area IN (?)', values)
      other_posts = Post.where("name LIKE ? OR title LIKE ? OR body LIKE?","%#{word}%", "%#{word}%", "%#{word}%")
      @post = ride_area_posts | other_posts
    else
      @post = Post.all
    end
  end

  def liked_by?(customer)
    likes.exists?(customer_id: customer.id)
  end

  def create_notification_like(current_user)
    notification = current_user.active_notifications.new(
      post_comment_id: nil,
      post_id: id,
      visited_id: customer_id,
      action: 'like'
      )
    if notification.visitor_id == notification.visited_id
       notification.checked = true
    end
    notification.save if notification.valid?
  end

  def create_notification_comment(current_user, post_comment_id)
    # 自分以外で投稿にコメントしているユーザーを取得
    temp_ids = PostComment.select(:customer_id).where(post_id: id).where.not(customer_id: current_user).distinct
    temp_ids.each do |temp_id|
      save_notification_comment(current_user, post_comment_id, temp_id['customer_id'])
    end
    save_notification_comment(current_user, post_comment_id, customer_id) if temp_ids.blank?
  end

  #(通知をした人,通知されたコメント,通知された人)
  def save_notification_comment(current_user, post_comment_id, visited_id)
    notification = current_user.active_notifications.new(
      post_id: id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end


   enum ride_area:{
     "---":0,
     北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
     茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
     新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
     岐阜県:21,静岡県:22,愛知県:23,三重県:24,
     滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
     鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
     徳島県:36,香川県:37,愛媛県:38,高知県:39,
     福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,
     沖縄県:47
   }

end
