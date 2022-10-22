class Message < ApplicationRecord
  
  validates :body, presence: true, length: { minimum: 1, maximum: 256 }
  
  belongs_to :customer
  belongs_to :room
end
