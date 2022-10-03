class Onsen < ApplicationRecord
  
  belongs_to :customer
  has_many :onsen_tags, dependent: :destroy
  has_many :onsen_comments, dependent: :destroy
  
end
