class Subhoot < ActiveRecord::Base
  belongs_to :user
  
  validates :post_id, presence: true
  validates :content, presence: true, length: { maximum: 50 }
  default_scope -> {order(created_at: :asc)}
end
