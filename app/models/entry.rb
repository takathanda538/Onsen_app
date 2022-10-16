class Entry < ApplicationRecord
  belongs_to :customer
  belongs_to :room
  
  validates :room_id, uniqueness: { scope: :customer_id }
end
