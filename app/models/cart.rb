class Cart < ApplicationRecord
  belongs_to :user

  enum cart_type: [ :buy_now, :buy_next_time ]
end
