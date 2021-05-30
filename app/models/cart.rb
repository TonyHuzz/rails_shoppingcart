class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items
  
  enum cart_type: [ :buy_now, :buy_next_time ]
end
