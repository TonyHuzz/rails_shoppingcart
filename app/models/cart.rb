class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items
  
  enum cart_type: [ :buy_now, :buy_next_time ]

  def amount
    @amount = 0

    cart_items.each do |item|
      @amount += item.quantity * (item.product_price)
    end

    return @amount
  end
end
