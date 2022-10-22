class Post < ApplicationRecord
  
  validates :name, presence: true, length: { minimum: 1, maximum: 35 }
  validates :ride_area, presence: true
  validates :title, presence: true, length: { minimum: 1, maximum: 180 }
  validates :body, presence: true, length: { minimum: 1, maximum: 450 }
  
  belongs_to :customer

  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_customers, through: :likes, source: :customer

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

  def liked_by?(user)
    likes.exists?(customer_id: user.id)
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
